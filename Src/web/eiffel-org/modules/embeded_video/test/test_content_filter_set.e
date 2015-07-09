note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONTENT_FILTER_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_video_filter
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[video:https://www.youtube.com/embed/jBMOSSnCMCk]"
			expected_text := "<iframe width=%"420%" height=%"315%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_2
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ video :  https://www.youtube.com/embed/jBMOSSnCMCk   ]"
			expected_text := "<iframe width=%"420%" height=%"315%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_3
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ video :https://www.youtube.com/embed/jBMOSSnCMCk   ]"
			expected_text := "<iframe width=%"420%" height=%"315%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_4
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ video :https://www.youtube.com/embed/jBMOSSnCMCk   height:425]"
			expected_text := "<iframe width=%"420%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_5
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ video :https://www.youtube.com/embed/jBMOSSnCMCk   height :  425]"
			expected_text := "<iframe width=%"420%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_6
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ video :https://www.youtube.com/embed/jBMOSSnCMCk   height :  425 width:   425]"
			expected_text := "<iframe width=%"425%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

	test_video_filter_7
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425]"
			expected_text := "<iframe width=%"425%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_8
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[height:425 width:425 video:https://www.youtube.com/embed/jBMOSSnCMCk ]"
			expected_text := "<iframe width=%"425%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_9
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ width:425  video:https://www.youtube.com/embed/jBMOSSnCMCk  height:425]"
			expected_text := "<iframe width=%"425%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

	test_video_filter_10
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[ wrong:425  video:https://www.youtube.com/embed/jBMOSSnCMCk  height:425]"
			expected_text := "<iframe width=%"420%" height=%"425%"%Nsrc=%"https://www.youtube.com/embed/jBMOSSnCMCk%">%N</iframe>"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


	test_video_filter_11
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "[wrong hello:1020 ]"
			expected_text := "[wrong hello:1020 ]"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end


end


