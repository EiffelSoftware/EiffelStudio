;# $Id: eval.pl 78389 2004-11-30 00:17:17Z manus $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log$
;# Revision 1.1  2004/11/30 00:17:18  manus
;# Initial revision
;#
;# Revision 3.0.1.1  1995/01/30  14:48:37  ram
;# patch49: removed old "do name()" routine call constructs
;#
;# Revision 3.0  1993/08/18  12:10:22  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# The built-in interpreter
;#
package interpreter;

# States used by our interpeter -- in sync with @Keep
sub main'init_keep {
	# Status in which we keep lines -- $Keep[$status]
	@Keep = (0, 1, 1, 0, 1);

	# Available status ($status)
	$SKIP = 0;
	$IF = 1;
	$ELSE = 2;
	$NOT = 3;
	$OUT = 4;
}

# Priorities for operators -- magic numbers :-)
sub main'init_priority {
	$Priority{'&&'} = 4;
	$Priority{'||'} = 3;
}

# Initializes the state stack of the interpreter
sub main'init_interp {
	@state = ();
	push(@state, $OUT);
}

# Print error messages -- asssumes $unit and $. correctly set.
sub error {
	warn "\"$main'file\", line $.: @_.\n";
}

# If some states are still in the stack, warn the user
sub main'check_state {
	&error("one statement pending") if $#state == 1;
	&error("$#state statements pending") if $#state > 1;
}

# Add a value on the stack, modified by all the monadic operators.
# We use the locals @val and @mono from eval_expr.
sub push_val {
	local($val) = shift(@_);
	while ($#mono >= 0) {
		# Cheat... the only monadic operator is '!'.
		pop(@mono);
		$val = !$val;
	}
	push(@val, $val);
}

# Execute a stacked operation, leave result in stack.
# We use the locals @val and @op from eval_expr.
# If the value stack holds only one operand, do nothing.
sub execute {
	return unless $#val > 0;
	local($op) = pop(@op);
	local($val1) = pop(@val);
	local($val2) = pop(@val);
	push(@val, eval("$val1 $op $val2") ? 1: 0);
}

# Given an operator, either we add it in the stack @op, because its
# priority is lower than the one on top of the stack, or we first execute
# the stacked operations until we reach the end of stack or an operand
# whose priority is lower than ours.
# We use the locals @val and @op from eval_expr.
sub update_stack {
	local($op) = shift(@_);		# Operator
	if (!$Priority{$op}) {
		&error("illegal operator $op");
		return;
	} else {
		if ($#val < 0) {
			&error("missing first operand for '$op' (diadic operator)");
			return;
		}
		# Because of the special behaviour of do-SUBR with the while modifier,
		# I'm using a while-BLOCK construct. I consider this to be a bug of perl
		# 4.0 PL19, although it is clearly documented in the man page.
		while (
			$Priority{$op[$#op]} > $Priority{$op}	# Higher priority op
			&& $#val > 0							# At least 2 values
		) {
			&execute;		# Execute an higher priority stacked operation
		}
		push(@op, $op);		# Everything at higher priority has been executed
	}
}

# This is the heart of our little interpreter. Here, we evaluate
# a logical expression and return its value.
sub eval_expr {
	local(*expr) = shift(@_);	# Expression to parse
	local(@val) = ();			# Stack of values
	local(@op) = ();			# Stack of diadic operators
	local(@mono) =();			# Stack of monadic operators
	local($tmp);
	$_ = $expr;
	while (1) {
		s/^\s+//;				# Remove spaces between words
		# The '(' construct
		if (s/^\(//) {
			&push_val(&eval_expr(*_));
			# A final '\' indicates an end of line
			&error("missing final parenthesis") if !s/^\\//;
		}
		# Found a ')' or end of line
		elsif (/^\)/ || /^$/) {
			s/^\)/\\/;						# Signals: left parenthesis found
			$expr = $_;						# Remove interpreted stuff
			&execute() while $#val > 0;		# Executed stacked operations
			while ($#op >= 0) {
				$_ = pop(@op);
				&error("missing second operand for '$_' (diadic operator)");
			}
			return $val[0];
		}
		# A perl statement '{{'
		elsif (s/^\{\{//) {
			if (s/^(.*)\}\}//) {
				&push_val((system
					('perl','-e', "if ($1) {exit 0;} else {exit 1;}"
					))? 0 : 1);
			} else {
				&error("incomplete perl statement");
			}
		}
		# A shell statement '{'
		elsif (s/^\{//) {
			if (s/^(.*)\}//) {
				&push_val((system
					("if $1 >/dev/null 2>&1; then exit 0; else exit 1; fi"
					))? 0 : 1);
			} else {
				&error("incomplete shell statement");
			}
		}
		# Operator '||' and '&&'
		elsif (s/^(\|\||&&)//) {
			$tmp = $1;			# Save for perl5 (Dataloaded update_stack)
			&update_stack($tmp);
		}
		# Unary operator '!'
		elsif (s/^!//) {
			push(@mono,'!');
		}
		# Everything else is a test for a defined value
		elsif (s/^([\?%]?\w+)//) {
			$tmp = $1;
			# Test for wanted
			if ($tmp =~ s/^\?//) {
				&push_val(($main'symwanted{$tmp})? 1 : 0);
			}
			# Test for conditionally wanted
			elsif ($tmp =~ s/^%//) {
				&push_val(($main'condwanted{$tmp})? 1 : 0);
			}
			# Default: test for definition (see op @define)
			else {
				&push_val((
					$main'symwanted{$tmp} ||
					$main'cmaster{$tmp} ||
					$main'userdef{$tmp}) ? 1 : 0);
			}
		}
		# An error occured -- we did not recognize the expression
		else {
			s/^([^\s\(\)\{\|&!]+)//;	# Skip until next meaningful char
		}
	}
}

# Given an expression in a '@' command, returns a boolean which is
# the result of the evaluation. Evaluate is collecting all the lines
# in the expression into a single string, and then calls eval_expr to
# really evaluate it.
sub evaluate {
	local($val);			# Value returned
	local($expr) = "";		# Expression to be parsed
	chop;
	while (s/\\$//) {		# While end of line escaped
		$expr .= $_;
		$_ = <UNIT>;		# Fetch next line
		unless ($_) {
			&error("EOF in expression");
			last;
		}
		chop;
	}
	$expr .= $_;
	while ($expr ne '') {
		$val = &eval_expr(*expr);		# Expression will be modified
		# We return from eval_expr either when a closing parenthisis
		# is found, or when the expression has been fully analysed.
		&error("extra closing parenthesis ignored") if $expr ne '';
	} 
	$val;
}

# Given a line, we search for commands (lines starting with '@').
# If there is no command in the line, then we return the boolean state.
# Otherwise, the command is analysed and a new state is computed.
# The returned value of interpret is 1 if the line is to be printed.
sub main'interpret {
	local($value);
	local($status) = $state[$#state];		# Current status
	if (s|^\s*@\s*(\w+)\s*(.*)|$2|) {
		local($cmd) = $1;
		$cmd =~ y/A-Z/a-z/;		# Canonicalize to lower case
		# The 'define' command
		if ($cmd eq 'define') {
			chop;
			$userdef{$_}++ if $Keep[$status];
			return 0;
		}
		# The 'if' command
		elsif ($cmd eq 'if') {
			# We always evaluate, in order to find possible errors
			$value = &evaluate($_);
			if (!$Keep[$status]) {
				# We have to skip until next 'end'
				push(@state, $SKIP);		# Record structure
				return 0;
			}
			if ($value) {			# True
				push(@state, $IF);
				return 0;
			} else {				# False
				push(@state, $NOT);
				return 0;
			}
		}
		# The 'else' command
		elsif ($cmd eq 'else') {
			&error("expression after 'else' ignored") if /\S/;
			$state[$#state] = $SKIP if $state[$#state] == $IF;
			return 0 if $state[$#state] == $SKIP;
			if ($state[$#state] == $OUT) {
				&error("unexpected 'else'");
				return 0;
			}
			$state[$#state] = $ELSE;
			return 0;
		}
		# The 'elsif' command
		elsif ($cmd eq 'elsif') {
			# We always evaluate, in order to find possible errors
			$value = &evaluate($_);
			$state[$#state] = $SKIP if $state[$#state] == $IF;
			return 0 if $state[$#state] == $SKIP;
			if ($state[$#state] == $OUT) {
				&error("unexpected 'elsif'");
				return 0;
			}
			if ($value) {			# True
				$state[$#state] = $IF;
				return 0;
			} else {				# False
				$state[$#state] = $NOT;
				return 0;
			}
		}
		# The 'end' command
		elsif ($cmd eq 'end') {
			&error("expression after 'end' ignored") if /\S/;
			pop(@state);
			&error("unexpected 'end'") if $#state < 0;
			return 0;
		}
		# Unknown command
		else {
			&error("unknown command '$cmd'");
			return 0;
		}
	}
	$Keep[$status];
}
		
package main;

