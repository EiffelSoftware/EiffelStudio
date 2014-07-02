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

#ifndef _NOTIFY_TOKEN_H
#define _NOTIFY_TOKEN_H

#include "qoq.hpp"
#include <memory>

class processor;

/* A notification mechanism.
 *
 * This is used to implement the wait-condition mechanism.
 * In particular it allows multiple suppliers to notify a single
 * client that they are ready.
 */
class notify_token
{
public:
  /* Construct a notify token.
   * @client the owner of the token
   */
  notify_token(processor *client);

  /* Copy constructor.
   * @other the token to copy.
   */
  notify_token(const notify_token& other);

  /* Register with a new supplier.
   * @supplier the new supplier to register with.
   *
   * This token is added to the notification list of the supplier.
   */
  void register_supplier (processor *supplier);

  /* Wait for a signal from any supplier.
   */
  void wait();

  /* Wake the supplier assocated with this token
   */
  void notify(processor *client);

  /* The processor for which this token is <processor::my_token>.
   *
   * @return the client associated with this token.
   */
  processor *client() const;

private:
  processor *client_;
  std::shared_ptr <mpscq<processor*> > token_queue_;
};

#endif // _NOTIFY_TOKEN_H
