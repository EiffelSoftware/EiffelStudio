// Copyright (C) 2013 Paul G. Crismer
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


/**
 * @fileoverview
 * Registers a language handler for Eiffel.
 *
 */

var PR_TTT='ttt';

PR['registerLangHandler'](
    PR['createSimpleLexer'](
        [
            // Whitespace
            // whitechar    ->    newline | vertab | space | tab | uniWhite
            // newline      ->    return linefeed | return | linefeed | formfeed
            [PR['PR_PLAIN'],       /^[\t\n\x0B\x0C\r ]+/, null, '\t\n\x0B\x0C\r '],

            [PR['PR_STRING'],      /^\"(?:[^\"\\\n\x0C\r]|\\[\s\S])*(?:\"|$)/,
                null, '"'],

            // Multi line strings delimited by "[ ]" or "{ }"
            [PR['PR_STRING'],      /^\"[\[{][\s\S]*?(?:[\]}]\"|$)/, null,
                '"'] ,

            // decimal      ->    digit{digit}
            // octal        ->    octit{octit}
            // hexadecimal  ->    hexit{hexit}
            // integer      ->    decimal
            //               |    0o octal | 0O octal
            //               |    0x hexadecimal | 0X hexadecimal
            // float        ->    decimal . decimal [exponent]
            //               |    decimal exponent
            // exponent     ->    (e | E) [+ | -] decimal
            // Warning: '_' can be used to separate digit groups.
            [PR['PR_LITERAL'],
                /^(?:0o[0-7_]+|0x[\da-f_]+|[0-9_]+(?:\.[0-9_]+)?(?:e[+\-]?\d+)?)/i,
                null, '0123456789']
        ],
        [
            // Comments in Eiffel are started with -- and go till a newline
            [PR['PR_COMMENT'], /^--[^\n]*/],


			/**
			 * Keywords
			 */
			[PR['PR_KEYWORD'], /^(?:across|agent|alias|all|and|as|assign|attached|attribute|check|class|convert|create|Current|debug|deferred|detachable|do|else|elseif|end|ensure|expanded|export|external|False|feature|from|frozen|if|implies|inherit|indexing|inspect|invariant|like|local|loop|not|note|obsolete|old|once|only|or|Precursor|redefine|reference|rename|require|rescue|Result|retry|select|separate|then|True|TUPLE|undefine|until|variant|Void|when|xor)\b/i, null],

			/*
			*  Eiffel specific
			*
			*  "atg" and "fcl" define new classes of tokens
			*  there must be corresponding css clauses to render them.
			*/

			["atg", /^[a-zA-Z][a-z0-9_]*[\ \t]*\:/ ], 	// Assertion TaG
			["fcl", /^\.[a-zA-Z][a-z0-9_]*/], 			// Function CaLl

			[PR['PR_TYPE'], /^[A-Z][A-Z0-9_]*/],

			[PR['PR_PLAIN'], /^[a-zA-Z][a-z0-9_]*/],
			// matches the symbol production

			[PR['PR_PUNCTUATION'], /^[\.,;]/],
			[PR['PR_PUNCTUATION'], /^\->/]
			]),
    ['eiffel']);
