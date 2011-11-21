note
	description: "This class represents the MCI_WAVE_SET_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_WAVE_SET_PARMS

inherit
	WEX_MCI_SET_PARMS
		rename
			make as set_make
		redefine
			structure_size
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW)
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			if not exists then
				structure_make
			end
			set_make (a_parent)
		ensure
			exists: exists
		end

feature -- Status report

        input_channel: INTEGER
                        -- Input channel
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_input (item)
                end

        output_device: INTEGER
                        -- Output device to use
                        --| Only usefull if more than one device
			--| is installed on system.
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_output (item)
                end

        format_tag: INTEGER
                        -- Format used.
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_format_tag (item)
                end

        channels: INTEGER
                        -- Channels to use, 1 for mono 2 for stereo
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_channels (item)
                end

        samples_per_second: INTEGER
                        -- Samples per seconds to use for recording.
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_samples_per_second (item)
                end

        bytes_per_second: INTEGER
                        -- Bytes per seconds to use for recording.
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_bytes_per_second (item)
                end

        block_alignment: INTEGER
                        -- Block align
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_block_align (item)
                end

        bits_per_sample: INTEGER
                        -- Bits per sample to use for recording.
                require
                        exists: exists
                do
                        Result := cwex_mci_wave_get_bits_per_sample (item)
                end

feature -- Status setting

        set_input_channel (channel: INTEGER)
                        -- Set input channel to use.
                require
                        exists: exists
                do
                        cwex_mci_wave_set_input (item, channel)
                ensure
                        channel_set: channel = input_channel
                end

        set_output_device (device: INTEGER)
                        -- Set output device to use.
                require
                        exists: exists
                do
                        cwex_mci_wave_set_output (item, device)
                ensure
                        device_set: device = output_device
                end

        set_format_tag (tag: INTEGER)
                        -- Set format to use.
                require
                        exists: exists
                do
                        cwex_mci_wave_set_format_tag (item, tag)
                ensure
                        tag_set: format_tag = tag
                end

        set_channels (number: INTEGER)
                        -- Set number of channels to use.
                require
                        exists: exists
                        number_greater_than: number > 0
                        number_smaller_than: number < 3
                do
                        cwex_mci_wave_set_channels (item, number)
                ensure
                        channels_set: channels = number
                end

        set_samples_per_second (number: INTEGER)
                        -- Set a number of samples per second.
                require
                        exists: exists
                do
                        cwex_mci_wave_set_samples_per_second (item, number)
                ensure
                        samples_per_second_set: samples_per_second = number
                end

        set_bytes_per_second (number: INTEGER)
                        -- Set a number of bytes per second
                require
                        exists: exists
                do
                        cwex_mci_wave_set_bytes_per_second (item, number)
                ensure
                        bytes_per_second_set: bytes_per_second = number
                end

        set_block_alignment (number: INTEGER)
                        -- Set alignment to `number'
                require
                        exists: exists
                do
                        cwex_mci_wave_set_block_align (item, number)
                ensure
                        block_alignment_set: block_alignment = number
                end

        set_bits_per_sample (number: INTEGER)
                        -- Set number of bits per sample
                require
                        exists: exists
                do
                        cwex_mci_wave_set_bits_per_sample (item, number)
                ensure
                        bits_per_sample_set: bits_per_sample = number
                end

feature -- Measurements

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_wave_set_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_wave_set_parms: INTEGER
		external
			"C [macro <wave_set.h>]"
		alias
			"sizeof (MCI_WAVE_SET_PARMS)"
		end

        cwex_mci_wave_set_input (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_output (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_format_tag (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_channels (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_samples_per_second (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_bytes_per_second (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_block_align (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_set_bits_per_sample (p: POINTER; value: INTEGER)
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_input (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_output (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_format_tag (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_channels (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_samples_per_second (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_bytes_per_second (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_block_align (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

        cwex_mci_wave_get_bits_per_sample (p: POINTER): INTEGER
		external
			"C [macro <wave_set.h>]"
		end

end -- class WEX_MCI_WAVE_SET_PARMS

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
