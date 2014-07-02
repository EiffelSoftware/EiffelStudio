#include "queue_cache.hpp"
#include "processor.hpp"

priv_queue*
queue_cache::operator[] (processor * const supplier)
{
  const auto &found_it = queue_map.find (supplier);
  priv_queue *pq;
  if (found_it != queue_map.end())
    {
      auto &stack = found_it->second;
      if (stack.empty())
	{
	  stack.emplace_back (supplier->new_priv_queue());
	}
      pq = stack.back();
    }
  else
    {
      const auto &res = queue_map.emplace (supplier, queue_stack());
      auto &stack = res.first->second;
      stack.emplace_back (supplier->new_priv_queue());
      pq = stack.back();
    }

  return pq;
}
