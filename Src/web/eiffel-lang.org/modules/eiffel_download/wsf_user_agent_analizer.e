note
	description: "Summary description for {WSF_USER_AGENT_ANALIZER}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "src=https://github.com/JustinAzoff/splunk-scripts/blob/master/ua2os.py", "protocol=url"

class
	WSF_USER_AGENT_ANALIZER

feature -- Analyze

	analizer (a_req: WSF_REQUEST)
			-- Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.104 Safari/537.36
		local
			l_ua: READABLE_STRING_GENERAL
		do
			if attached a_req.http_user_agent as l_user_agent then
				l_ua := l_user_agent.as_lower
			    set_platform (l_ua)
				set_os_family (l_ua)
			end

		end

feature -- Access

	platform: detachable READABLE_STRING_32
			-- Current platform 32 or 64 bits.

	os_family: detachable READABLE_STRING_32
			-- Current OS platform.





--arch_mapping = (
--    ('Windows .. 5.2',                 'x64'),
--    ('x64',                     		'x64'),
--    ('Win64',                          'x64'),
--    ('Windows .. 6.1.*WOW64',                   'x64'),
--    ('Windows .. 6.([012])\; Trident/',         'i386'),
--    ('i386',               	 		'i386'),
--    ('i686',                                    'i686'),
--    ('x86_64',              			'x64'),
--    ('amd64',                                   'x64'),
--    ('PPC',                 			'PowerPC'),
--    ('Power.{1,3}Macint',   			'PowerPC'),
--    ('droid',               			'android'),
--    ('iPad',                			'ipad'),
--    ('iPod',                			'ipod'),
--    ('iPhone',              			'iphone'),
--    ('Intel',               			'Intel'),
--    ('BlackBerry (\d+)',          		'BlackBerry %s'),
--    ('BlackBerry',				'BlackBerry'),
--    ('BB10',                                    'BlackBerry 10'),
--    ('Playbook',                                'BlackBerry Playbook'),
--    ('hp-tablet',                               'HP Tablet'),
--    ('armv(\d+)',                               'ARM v%s'),
--)

feature -- Change Element

	set_platform (a_user_agent: READABLE_STRING_GENERAL)
		do
			if a_user_agent.has_substring ("windows .. 5.2") or a_user_agent.has_substring ("x64") or a_user_agent.has_substring ("win64") or a_user_agent.has_substring ("wow64") or
			   a_user_agent.has_substring ("x86_64") or a_user_agent.has_substring ("amd64") then
			   platform := "64"
			 else
			   platform := "32"
			 end
		end

	set_os_family (a_user_agent: READABLE_STRING_GENERAL)
		do
			if a_user_agent.has_substring ("windows") or a_user_agent.has_substring ("winhttp") or a_user_agent.has_substring ("msie") or a_user_agent.has_substring ("microsoft") or a_user_agent.has_substring ("win32") then
				os_family := "win"
			elseif a_user_agent.has_substring ("os x") or a_user_agent.has_substring ("darwin") then
				os_family := "mac"
			elseif a_user_agent.has_substring ("sunos") then
				os_family := "solaris"
			elseif a_user_agent.has_substring ("os/2") then
				os_family := "os/2"
			elseif a_user_agent.has_substring ("linux") or a_user_agent.has_substring ("urlgrabber/.* yum") then
				os_family := "linux"
			elseif a_user_agent.has_substring ("freebsd") then
				os_family := "freebsd"
			end
		end
--os_mapping = (
--    ('Windows .. 5.1',      'Windows XP'),
--    ('Windows .. 5.2',      'Windows XP'),
--    ('Windows NT 6.0',      'Windows Vista'),
--    ('Windows 6.0',         'Windows Server 2008'),
--    ('Windows NT 6.1',      'Windows 7'),
--    ('Windows NT 6.2',      'Windows 8'),
--    ('OS X 10.(\d)',        'MAC OS X 10.%s.x'),
--    ('SunOS',               'Solaris'),
--    ('droid',               'Android'),
--    ('Windows',             'Windows - Other'),
--    ('iPad',                'ipad'),
--    ('iPod',                'ipod'),
--    ('iPhone',              'iphone'),
--    ('OS X',                'MAC OS X other'),
--    ('Darwin',              'MAC OS X other'),
--    ('Linux ',              'Linux'),
--    ('winhttp',             'Windows - Other'),
--    ('MSIE 4.0;',           'Windows - Other'),
--    ('Microsoft',           'Windows - Other'),
--    ('Win32',               'Windows - Other'),
--    ('BlackBerry',          'BlackBerry'),
--    ('BB10',                'BlackBerry 10'),
--    ('RIM (\S+ \S+ \S+)',   'BlackBerry %s'),
--    ('OS/2',                'OS/2'),
--    ('urlgrabber/.* yum',   'Linux - redhat/fedora'),
--    ('Skype for Macintosh', 'MAC OS X other'),
--    ('Xbox Live Client',    'Xbox'),
--    ('hpwOS/(\S+)',         'HP webOS %s'),
--    ('J2ME',                'JVM Micro Edition'),
--    ('CrOS',                'Chromium OS'),
--    ('FreeBSD',             'FreeBSD'),
--)		
end
