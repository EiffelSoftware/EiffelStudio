
deferred class SCALABLE

feature

	update_ratios (a_widget: WIDGET) is
		require
			valid_widget: a_widget /= Void;
		deferred
		end;

	follow_x (a_widget: WIDGET; a_flag: BOOLEAN) is
		require
			valid_widget: a_widget /= Void;
			valid_flag: a_flag /= Void;
		deferred
		end;

	follow_y (a_widget: WIDGET; a_flag: BOOLEAN) is
		require
			valid_widget: a_widget /= Void;
			valid_flag: a_flag /= Void;
		deferred
		end;

	width_resizeable (a_widget: WIDGET; a_flag: BOOLEAN) is
		require
			valid_flag: a_flag /= Void;
		deferred
		end;

	height_resizeable (a_widget: WIDGET;a_flag: BOOLEAN) is
		require
			valid_flag: a_flag /= Void;
		deferred
		end;
end
