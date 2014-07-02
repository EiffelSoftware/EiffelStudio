// Copyright (c) 2010-2011 Dmitry Vyukov. All rights reserved.

// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:

//    1. Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.

//    2. Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.

// THIS SOFTWARE IS PROVIDED BY DMITRY VYUKOV "AS IS" AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL DMITRY VYUKOV OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
// IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// The views and conclusions contained in the software and documentation
// are those of the authors and should not be interpreted as representing
// official policies, either expressed or implied, of Dmitry Vyukov.

#ifndef _SPSC_H
#define _SPSC_H
#include <atomic>
#include <mutex>
#include <condition_variable>

#define __memory_barrier() atomic_thread_fence (std::memory_order_seq_cst)

// load with 'consume' (data-dependent) memory ordering
template<typename T>
T load_consume(T const* addr)
{
  // hardware fence is implicit on x86
  T v = *const_cast<T const volatile*>(addr);
  __memory_barrier(); // compiler fence
  return v;
}

// store with 'release' memory ordering
template<typename T>
void store_release(T* addr, T v)
{
  // hardware fence is implicit on x86
  __memory_barrier(); // compiler fence
  *const_cast<T volatile*>(addr) = v;
}


// cache line size on modern x86 processors (in bytes)
size_t const cache_line_size = 64;

template<typename T>
class spsc;

// A non-blocking single-producer/single-consumer queue.
template<typename T>
class spsc_queue_impl
{
  friend class spsc<T>;
public:
  spsc_queue_impl()
  {
    node* n = new node();
    n->next_ = 0;
    tail_ = head_ = first_= tail_copy_ = n;
  }

  ~spsc_queue_impl()
  {
    node* n = first_;
    do
      {
        node* next = n->next_;
        delete n;
        n = next;
      }
    while (n);
  }

  void enqueue(T v)
  {
    node* n = alloc_node();
    n->next_ = 0;
    n->value_ = v;

    store_release(&head_->next_, n);

    head_ = n;
  }

  // returns 'false' if queue is empty
  bool dequeue(T& v)
  {
    if (load_consume(&tail_->next_))
      {
        v = tail_->next_->value_;
        store_release(&tail_, tail_->next_);
        return true;
      }
    else
      {
        return false;
      }
  }

private:
  // internal node structure
  struct node
  {
    node* next_;
    T value_;
  };

  // consumer part
  // accessed mainly by consumer, infrequently be producer
  node* tail_; // tail of the queue

  // delimiter between consumer part and producer part,
  // so that they situated on different cache lines
  char cache_line_pad_ [cache_line_size];

  // producer part
  // accessed only by producer
  node* head_; // head of the queue
  node* first_; // last unused node (tail of node cache)
  node* tail_copy_; // helper (points somewhere between first_ and tail_)

  node* alloc_node()
  {
    // first tries to allocate node from internal node cache,
    // if attempt fails, allocates node via ::operator new()

    if (first_ != tail_copy_)
      {
        node* n = first_;
        first_ = first_->next_;
        return n;
      }
    tail_copy_ = load_consume(&tail_);
    if (first_ != tail_copy_)
      {
        node* n = first_;
        first_ = first_->next_;
        return n;
      }
    node* n = new node();
    return n;
  }

  spsc_queue_impl(spsc_queue_impl const&);
  spsc_queue_impl & operator = (spsc_queue_impl const&);
};

/* A blocking single-producer single-consumer queue.
 *
 * This can only be used for reliable sending between a single producer
 * and consumer.
 */
template <typename T>
class spsc
{
public:
  spsc()
  {
  }

  void
  pop(T &v, int spin = 512)
  {
    for (int i = 0; i < spin; i++)
      {
        if (q.dequeue(v))
          {
            return;
          }
      }

    {
      eif_lock lock (mutex);
      while (!q.dequeue(v))
        {
          cv.wait(lock);
        }
    }
  }

  void
  push(T v)
  {
    q.enqueue(v);

    {
      std::unique_lock<std::mutex> lock (mutex);
      cv.notify_one();
    }
  }


  int
  size ()
  {
    int s = 0;
    for (auto n = q.tail_->next_ ; n ; n = n->next_)
      {
        s++;
      }
    return s;
  }

  void
  unsafe_map_ (std::function <void(T)> f)
  {
    for (auto n = q.tail_->next_ ; n ; n = n->next_)
      {
        f (n->value_);
      }
  }
private:
  spsc_queue_impl<T> q;
  std::mutex mutex;
  std::condition_variable cv;
};

#endif // _SPSC_H
