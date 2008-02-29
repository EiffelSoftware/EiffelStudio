/*
 * This is a prototypical patchlevel.h file. Only the line defining
 * the PATCHLEVEL symbol is taken into account when patching, so be
 * sure to make changes to this file ONLY when you start a new release
 * and, of course, before running patcil...
 *
 * This file must appear in your MANIFEST.new, but it will never be
 * checked in by the pat tools. It is automatically updated when a new
 * patch is issued.
 *
 * When using the '-n' option in some pat* scripts, this file is
 * taken as a timestamp. So it is best to avoid manual editing unless
 * you know what you are doing.
 */

/*
 * $Id$
 *
 *  Copyright (c) 1991, Raphael Manfredi
 *
 *  You may redistribute only under the terms of the GNU General Public
 *  Licence as specified in the README file that comes with dist.
 *
 * $Log$
 * Revision 1.1  2004/11/30 00:17:18  manus
 * Initial revision
 *
 * Revision 3.0  1993/08/18  12:10:39  ram
 * Baseline for dist 3.0 netwide release.
 *
 */

#define VERSION 3.0			/* For instance */
#define PATCHLEVEL 0		/* This line is a mandatory */
