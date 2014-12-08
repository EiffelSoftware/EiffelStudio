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

#include <assert.h>
#include "eif_utils.hpp"

static
void
mark_ref (marker_t mark, EIF_REFERENCE *ref)
{
  assert (*ref);
  *ref = mark (ref);
}

void
mark_call_data(marker_t mark, call_data* call)
{
  assert (call && "Cannot mark NULL calls");
  mark_ref (mark, (EIF_REFERENCE*)(&call->target));

  for (size_t i = 0; i < call->count; i++)
    {
      if (call->argument[i].type == SK_REF)
        {
	  mark_ref (mark, &call->argument[i].it_r);
        }
    }
}

