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

#include <cassert>
#include "eif_utils.hpp"

template<typename T>
class mpmc_bounded_queue
{
public:
  mpmc_bounded_queue(size_t a_buffer_size)
    : buffer_(new cell_t [a_buffer_size])
    , buffer_mask_(a_buffer_size - 1)
  {
    assert((a_buffer_size >= 2) && ((a_buffer_size & (a_buffer_size - 1)) == 0));
    for (size_t i = 0; i != a_buffer_size; i += 1)
      buffer_[i].sequence_.store(i, memory_order_relaxed_const);
    enqueue_pos_.store(0, memory_order_relaxed_const);
    dequeue_pos_.store(0, memory_order_relaxed_const);
    size_ = 0;
  }

  ~mpmc_bounded_queue()
  {
    delete [] buffer_;
  }

  bool enqueue(T const& data)
  {
    cell_t* cell;
    size_t pos = enqueue_pos_.load(memory_order_relaxed_const);
    for (;;)
      {
	cell = &buffer_[pos & buffer_mask_];
	size_t seq = cell->sequence_.load(memory_order_acquire_const);
	intptr_t dif = (intptr_t)seq - (intptr_t)pos;
	if (dif == 0)
	  {
	    if (enqueue_pos_.compare_exchange_weak (pos,
						    pos + 1,
						    memory_order_relaxed_const))
	      break;
	  }
	else if (dif < 0)
	  return false;
	else
	  pos = enqueue_pos_.load(memory_order_relaxed_const);
      }
    cell->data_ = data;
    cell->sequence_.store(pos + 1, memory_order_release_const);
    size_++;
    return true;
  }

  bool dequeue(T& data)
  {
    cell_t* cell;
    size_t pos = dequeue_pos_.load(memory_order_relaxed_const);
    for (;;)
      {
	cell = &buffer_[pos & buffer_mask_];
	size_t seq = cell->sequence_.load(memory_order_acquire_const);
	intptr_t dif = (intptr_t)seq - (intptr_t)(pos + 1);
	if (dif == 0)
	  {
	    if (dequeue_pos_.compare_exchange_weak (pos,
						    pos + 1,
						    memory_order_relaxed_const))
	      break;
	  }
	else if (dif < 0)
	  return false;
	else
	  pos = dequeue_pos_.load(memory_order_relaxed_const);
      }
    data = cell->data_;
    cell->sequence_.store (pos + buffer_mask_ + 1, memory_order_release_const);
    size_--;
    return true;
  }

  size_t size() const 
  {
    return size_;
  }

private:
  struct cell_t
  {
    atomic_size_t_type    sequence_;
    T                     data_;
  };

  static size_t const     cacheline_size = 64;
  typedef char            cacheline_pad_t [cacheline_size];
  atomic_size_t_type      size_;

  cacheline_pad_t         pad0_;
  cell_t* const           buffer_;
  size_t const            buffer_mask_;
  cacheline_pad_t         pad1_;
  atomic_size_t_type      enqueue_pos_;
  cacheline_pad_t         pad2_;
  atomic_size_t_type      dequeue_pos_;
  cacheline_pad_t         pad3_;

  mpmc_bounded_queue(mpmc_bounded_queue const&);
  void operator = (mpmc_bounded_queue const&);
}; 
