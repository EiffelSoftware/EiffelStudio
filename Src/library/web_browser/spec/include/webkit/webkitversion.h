/*
 * Copyright (C) 2008 Christian Dywan <christian@imendio.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#ifndef webkitversion_h
#define webkitversion_h

#include <glib.h>
#include <webkit/webkitdefines.h>

G_BEGIN_DECLS

#define WEBKIT_MAJOR_VERSION (1)
#define WEBKIT_MINOR_VERSION (8)
#define WEBKIT_MICRO_VERSION (3)
#define WEBKIT_USER_AGENT_MAJOR_VERSION (535)
#define WEBKIT_USER_AGENT_MINOR_VERSION (22)
#define WEBKITGTK_API_VERSION (1.0)

#define WEBKIT_CHECK_VERSION(major, minor, micro) \
  (WEBKIT_MAJOR_VERSION > (major) || \
  (WEBKIT_MAJOR_VERSION == (major) && WEBKIT_MINOR_VERSION > (minor)) || \
  (WEBKIT_MAJOR_VERSION == (major) && WEBKIT_MINOR_VERSION == (minor) && \
  WEBKIT_MICRO_VERSION >= (micro)))

WEBKIT_API guint
webkit_major_version (void);

WEBKIT_API guint
webkit_minor_version (void);

WEBKIT_API guint
webkit_micro_version (void);

WEBKIT_API gboolean
webkit_check_version (guint major, guint minor, guint micro);

G_END_DECLS

#endif
