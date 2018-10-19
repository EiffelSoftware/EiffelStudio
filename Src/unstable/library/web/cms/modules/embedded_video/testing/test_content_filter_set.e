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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"420%" height=%"315%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"420%" height=%"315%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"420%" height=%"315%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"420%" height=%"425%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"420%" height=%"425%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe>"
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
			expected_text := "<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"420%" height=%"425%" wrong=%"425%"></iframe>"
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

			text := ""; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string (""))

			text := "123"; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("123"))

			text := "[]"; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("[]"))

			text := "[]["; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("[]["))

			text := "["; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("["))

			text := "[[[[[["; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("[[[[[["))

			text := "[[[[[[]"; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("[[[[[[]"))

			text := "[[[[[[end"; create f; f.filter (text)
			assert ("expected iframe with video", text.same_string ("[[[[[[end"))
		end


	test_video_filter_12
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "begin [video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425] end"
			expected_text := "begin <iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe> end"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

	test_video_filter_13
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "begin [wrong hello:123] [video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425] end [foobar]"
			expected_text := "begin [wrong hello:123] <iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe> end [foobar]"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

	test_video_filter_14
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "begin [wrong hello:123] [video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425][video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425][video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425]%N[video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:426] end [foobar]"
			expected_text := "begin [wrong hello:123] <iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe><iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe><iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe>%N<iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"426%" height=%"425%"></iframe> end [foobar]"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

	test_video_filter_15
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "begin [video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425 allowfullscreen] end [foobar]"
			expected_text := "begin <iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%" allowfullscreen></iframe> end [foobar]"
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

	test_video_filter_unicode
			-- New test routine
		local
			f: VIDEO_CONTENT_FILTER
			text: STRING_32
			expected_text: STRING_32
		do
			create text.make (100)
			text.append_code (20320)
			text.append_code (22909)
			text.append_code (21527)
			text.append_string_general ("begin [wrong hello:123] [video:https://www.youtube.com/embed/jBMOSSnCMCk height:425 width:425] end [foobar]")

			create expected_text.make (100)
			expected_text.append_code (20320)
			expected_text.append_code (22909)
			expected_text.append_code (21527)
			expected_text.append_string_general ("begin [wrong hello:123] <iframe src=%"https://www.youtube.com/embed/jBMOSSnCMCk%" width=%"425%" height=%"425%"></iframe> end [foobar]")
			create f
			f.filter (text)
			assert ("expected iframe with video", text.same_string (expected_text))
		end

end


