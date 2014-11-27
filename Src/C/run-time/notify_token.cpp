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

#include "notify_token.hpp"
#include "processor.hpp"

notify_token::notify_token(processor *client) :
  client_(client),
  token_queue_(make_shared_function <mpscq <processor*>> ())
{
}

notify_token::notify_token(const notify_token& other) :
  client_(other.client_),
  token_queue_(other.token_queue_)
{
}

void
notify_token::register_supplier (processor *supplier)
{ 
  supplier->register_notify_token (*this);
}

processor*
notify_token::client() const
{
  return client_;
}

void
notify_token::wait()
{
  processor* dummy;
  token_queue_->pop (dummy);
}

void
notify_token::notify(processor *client)
{
  token_queue_->push (client);
}
