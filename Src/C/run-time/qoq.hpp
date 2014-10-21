
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

#ifndef _QOQ_H
#define _QOQ_H

// This class is an adaptation of the MPSC queue by Dmitry Vyukov to use
// a TBB allocator and offer a blocking behaviour when the queue is empty.

#include <atomic>
#include <mutex>
#include <condition_variable>
#include "eif_utils.hpp"

template <typename V>
struct mpscq_node
{ 
  std::atomic<mpscq_node <V> *> volatile next;
  V state;
}; 

template <typename V>
class mpscq
{
public:
  mpscq()
  {
    mpscq_node <V> * stub = new mpscq_node<V>();
    stub->next = 0;
    head_ = stub;
    tail_ = stub;
  }

  void
  push(V v)
  {
    mpscq_node <V> * node = new mpscq_node<V>();
    node->state = v;

    push_(node);

    {
      conditional_unique_lock_type lock (mutex);
      cv.notify_all();
    }
  }

  void
  pop(V &v)
  {
    mpscq_node <V> *node;

    for (int i = 0; i < 128; i++)
      {
        if ((node = pop_()) != 0)
          {
            goto cleanup;
          }
      }

    {
      eif_lock lock (mutex);
      while ((node = pop_()) == 0)
        {
          cv.wait(lock);
        }
    }

  cleanup:
    v = node->state;    
    delete node;
  }

  bool
  is_empty()
  {
    return (void *) tail_->next == (void *) 0;
  }

private:
  void push_(mpscq_node<V> * n)
  {
    n->next = 0; 
    mpscq_node <V> * prev = head_.exchange(n); // serialization-point wrt 
                                               // producers, acquire-release
    prev->next = n; // serialization-point wrt consumer, release    
  }

  mpscq_node <V> * pop_() 
  { 
    mpscq_node <V> *tail = tail_;
    mpscq_node <V> *next = tail->next; // serialization-point wrt producers,
                                       // acquire
    if (next) 
      { 
        tail_ = next; 
        tail->state = next->state; 
        return tail; 
      } 
    return 0; 
  }

private:
  std::atomic<mpscq_node <V>*> volatile  head_;
  mpscq_node <V> *           tail_;

private: // Synchronization structures
  conditional_mutex_type mutex;
  condition_variable_type cv;
};

class processor;
class priv_queue;

struct qoq_item
{
  qoq_item (processor *proc, priv_queue *q) :
    is_done (false),
    client (proc),
    queue (q)
  {
  }

  qoq_item () : is_done(true)
  {
  }

  bool is_done;
  processor *client;
  priv_queue *queue;
};

#endif // _QOQ_H
