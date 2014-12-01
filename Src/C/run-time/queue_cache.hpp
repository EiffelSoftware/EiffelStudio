#ifndef _QUEUE_CACHE_H_
#define _QUEUE_CACHE_H_
#include <stack>
#include <set>
#include <vector>
#include "private_queue.hpp"

/* unordered_map is not available on all platforms.
 * It is replaced conditionally by something else. */
#if defined (__EIF_GNUC_VERSION__) && (__EIF_GNUC_VERSION__ < 40300)
#	include <ext/hash_map>
#	define unordered_map __gnu_cxx::hash_map
#else
#	include <unordered_map>
#	define unordered_map std::unordered_map
#endif

/* A cache of private queues.
 *
 * This cache of private queues creates new private queues on demand.
 * It also handles moving private queues from one processor to 
 * another, which occurs during lock-passing.
 */
class queue_cache {
public:
  /* Construct a new queue_cache.
   * @o the owner of this queue cache
   */
  queue_cache(processor* o) :
    owner (o),
    sub_map(),
    sub_stack(),
    queue_map(),
    lock_stack()
  {
    sub_map[o] = 1;
  }


private:
  typedef std::vector<priv_queue*> queue_stack;
 
  processor *owner;

  // The scheme for tracking the locks is to now use maps to stacks (or counts
  // for subordinates) to provide a mechanism that can have efficient
  // lookup, and still be able to push/pop these values.
  //
  // The goal is to first have efficient priv_queue lookup, as that is a very
  // common operation, while the push/pop operations are somewhat more expensive.
  unordered_map <processor*, uint32_t> sub_map;
  std::stack<std::set<processor*> > sub_stack;

  unordered_map <processor*, queue_stack> queue_map;
  std::stack<std::set<processor*> > lock_stack;

public:
  /* Fetches a new private queue.
   * @supplier the receiver of the returned private queue
   *
   * A new <priv_queue> will be constructed if none already exists
   * for the desire supplier <processor>. This will also look to see
   * if there are any private queues that were passed to this <queue_cache>
   * during lock-passing. These passed-queues will already be locked,
   * so they will be returned before returning a non-passed unlocked queue.
   *
   * @return the queue ending at the supplier
   */
  priv_queue*
  operator[] (processor * const supplier);

  /* Locked status.
   * @proc the supplier <processor> to query for lock acquisition
   *
   * @return true if there is a queue which currently holds a lock on the
   *         desired processor, false otherwise.
   */
  bool
  has_locked (processor *proc) const
  {
    unordered_map <processor*, queue_stack>::const_iterator found_it = queue_map.find (proc);
    if (found_it != queue_map.end())
      {
	const queue_stack &stack = found_it->second;
	return !stack.empty() && stack.back()->is_locked();
      }

    return false;
  }

  /* Subordinate status.
   * @proc the supplier <processor> of interest which may be a subordinate
   *       of the owner of this <queue_cache>.
   * 
   * @return true if the proc is a subordinate, false otherwise.
   */
  bool
  has_subordinate (processor *proc) const
  {
    unordered_map <processor*, uint32_t>::const_iterator res = sub_map.find (proc);
    return res != sub_map.end() && res->second > 0;
  }
  
public:
  /* Lock passing push.
   * @other the <queue_cache> to pass the locks from.
   * 
   * The locks (<priv_queue>s) from the other processor will be added to
   * this cache, and the owner of the other cache will be added to the
   * subordinates along with any of its subordinates.
   * This should be called in pairs with <pop>.
   */ 
  void
  push (const queue_cache* other)
  {
    std::set <processor*> new_locks;
    unordered_map <processor*, queue_stack> other_queue_map = other -> queue_map;
    for (unordered_map <processor*, queue_stack>::const_iterator pair = other_queue_map.begin (); pair != other_queue_map.end (); ++ pair)
      {
	processor* const supplier = (*pair).first;
	const queue_stack &stack = (*pair).second;

	if (!stack.empty() && stack.back()->is_locked())
	  {
	    priv_queue *pq = stack.back();
	    new_locks.insert (supplier);

	    if (queue_map.find (supplier) == queue_map.end())
	      {
		queue_map [supplier] = queue_stack();
	      }
	    queue_map [supplier].emplace_back (pq);
	  }
      }
    lock_stack.push (new_locks);

    std::set <processor*> new_subs;
    unordered_map <processor*, uint32_t> other_sub_map = other->sub_map;
    for (unordered_map <processor*, uint32_t>::const_iterator pair = other_sub_map.begin (); pair != other_sub_map.end (); ++ pair )
      {
	processor* const supplier = (*pair).first;
	const uint32_t count = (*pair).second;

	if (count > 0)
	  {
	    new_subs.insert (supplier);

	    if (sub_map.find (supplier) == sub_map.end())
	      {
		sub_map [supplier] = 0;
	      }
	    sub_map [supplier]++;
	  }
      }
    sub_stack.push (new_subs);
  }


  /* Remove last passed locks.
   *
   * The previously passed locks and subordinates will be removed. This
   * pairs naturally with the <push> that originally passed the locks.
   */
  void
  pop ()
  {
    const std::set<processor*> newest_locks = lock_stack.top();
    for (std::set<processor*>::const_iterator supplier = newest_locks.begin (); supplier != newest_locks.end (); ++ supplier)
      {
	queue_map [*supplier].pop_back();
      }
    lock_stack.pop();

    const std::set<processor*> newest_subs = sub_stack.top();
    for (std::set<processor*>::const_iterator supplier = newest_subs.begin (); supplier != newest_subs.end (); ++ supplier)
      {
	sub_map [*supplier]--;
      }
    sub_stack.pop();
  }

public:
  /* GC marking.
   * @mark the marking function to use on each reference from the Eiffel
   * runtime.
   *
   * Marks the calls that may be in the queues and thus otherwise invisible,
   * to the Eiffel runtime.
   */
  void
  mark (marker_t mark)
  {
    for (unordered_map <processor*, queue_stack>::const_iterator pair = queue_map.begin (); pair != queue_map.end (); ++ pair)
    {
      const queue_stack &stack = (*pair).second;
      for (queue_stack::const_iterator pq = stack.begin (); pq != stack.end (); ++ pq)
	{
	  (* pq) -> mark (mark);
	}
    }
  }

public:
  void clear (processor *proc)
  {
    queue_map.erase (proc);
  }

};

#endif // _QUEUE_CACHE_H_
