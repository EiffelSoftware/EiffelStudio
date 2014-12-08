//
// EVE/Qs - A new runtime for the EVE SCOOP implementation
// Copyright (C) 2014 Scott West <scott.gregory.west@gmail.com>
//
// This file is part of EVE/Qs.
//
// EVE/Qs is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// EVE/Qs is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with EVE/Qs.  If not, see <http://www.gnu.org/licenses/>.
//

#ifndef _REQ_GRP_H
#define _REQ_GRP_H
#include <vector>

class processor;
class priv_queue;

/* A request group.
 *
 * Request groups model the group of locks taken and released. This
 * generally occurs when a call has separate arguments.
 */
class req_grp : public std::vector<priv_queue*>
{
public:
  /* Construct a new group.
   * @client the <processor> which will issue calls to the group.
   */
  req_grp(processor* client);

  /* Add a new processor to the group.
   * @supplier the supplier to add
   */
  void add(processor* supplier);

  /* Wait on all processors in the group.
   *
   * This call will only return when one of the group sends a notification.
   */
  void wait();

  /* Lock all processors in the group.
   */
  void lock();

  /* Unlock all processors in the group.
   */
  void unlock();
private:
  processor *client;
  bool sorted;
};

#endif // _REQ_GRP_H
