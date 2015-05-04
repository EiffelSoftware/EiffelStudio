
<p>Do you love the Eiffel language, method, tools and libraries but would like them to be even better? You can help. The entire technology is available under the GPL Open Source license, so that all developers can participate in its evolution. The future of Eiffel is in the hands of the community.</p> 

<p>There are many ways to contribute, each detailed in the following sections:</p>
<ul>
	<li><a href="#libraries">Libraries</a></li>
	<li><a href="#documentation">Documentation, including videos</a></li>
	<li><a href="#community">Community site</a> (<a href="http://www.eiffel.org">http://www.eiffel.org</a>)</li>
	<li><a href="#flagship">Flagship applications</a></li>
	<li><a href="#tools">Tools and ports to new platforms</a></li>
	<li><a href="#testing">Testing and bug fixing</a></li>
	<li><a href="#everything">Everything else!</a></li>
</ul>

<p>
Everyone can be a contributor. If you are an Eiffel wizard, the community needs your experience. But even if you are fairly new to Eiffel, you can help! You will find that the community is always willing to support you and provide Eiffel expertise to complement your own special skills.
</p>

<h2>
<a name="libraries">1. Libraries</a>
</h2>

<p>Much of the Eiffel story is about reuse of high-quality components. Eiffel applications need these components. Library contributions can be of many kinds, some straightforward, some more ambitious:
</p>
<ul>
	<li>	
		In some cases, components are available in other languages such as C. Eiffel has a sophisticated C/C++ interface, which makes it easy to produce a simple Eiffel library that calls out to this existing code. Such a simple <strong>wrapper</strong> can be a significant contribution: it avoids duplication of effort and makes sure that everyone uses the same API, which can then be improved and extended for the benefit of the community. 
	</li>
	<li>
		Sometimes a wrapper already exists, but it is too low-level: not object-oriented, not equipped with contracts. Turning it into a real Eiffel library by adding a <strong>higher-level layer</strong> is an exciting project. For example, see the difference between WEL, the Windows Eiffel Library, a wrapper around Windows graphics, and the EiffelVision library, which internally relies on WEL (and similar wrappers on platforms other than Windows) to provide platform-independent graphics through an elegant object-oriented API.
	<li>
		There is always a need to <strong>extend existing libraries</strong>, such as EiffelBase (fundamental data structures and algorithms).	
	</li>
	<li>
		And of course there is room for many other pure-Eiffel developments in new areas.
	</li>
</ul>  

<h3><i>Before you start</i></h3>
<p>Watch the short video explaining <a href="https://youtu.be/rcSQv01qVcg">how to create a library project in Eiffel</a> and read the descriptions of existing <a href="/libraries">Eiffel Libraries.</a></p> 

<h2><a name="documentation">2. Documentation and videos</a></h2>
<p>There are lots of Eiffel documentation around, but also lots of remaining work:</p>
<ul>
	<li>Eiffel has undergone continuous improvements. Some documentation refers to earlier states of the technology. A useful contribution is to <strong>look for obsolete articles</strong>. Help clean up the documentation so that new and not-so-new users get a clear, consistent, up-to-date picture.</li>
	<li>Eiffel offers innovative, forward-looking answers to many programming and software engineering issues. Wikipedia entries on these topics do not always mention the Eiffel solutions. <strong>Anyone can update Wikipedia</strong> to explain relevant Eiffel techniques. A list of Wikipedia entries that would benefit from new or improved Eiffel information is available at <strong>[to be completed]</strong>.</li>
	<li>Some of the documentation, while good, is meant for experienced developers. Beginners need more <strong>tutorial-style</strong> presentations.</li>
</ul>
<p>A particularly good way to produce useful documentation at modest effort is to record videos. There is an Eiffel Channel on YouTube, with excellent presentations, and a need for many more.</p>

<h3><i>Before you start</i></h3>
[to be completed]. 

<h2><a name="community">3. Community site</a> (eiffel.org)</h2>
<p>The http://eiffel.org site is the site for the entire Eiffel community and the natural place to go first for newcomers and experts alike. You can help continue improve it:</p>
<ul>
	<li>Share <strong>news</strong> of interest to the Eiffel community.</li>
	<li>Share links to <strong>blogs</strong> and RSS feeds.</li>
	<li><strong>Link</strong> to eiffel.org from other sites.</li>
</ul>		

<h3><i>Before you start</i></h3>
[To be completed]

<h2><a name="flagship">4. Flagship applications</a></h2>
<p>
People want to know what others have done with Eiffel. Eiffel is routinely used to produce great applications, many of them deserving broader exposure.
Do you know of an interesting application written in Eiffel? Do you have a story to tell about how Eiffel succeeded when everything else had failed? Do you simply want to showcase your project, large or small? Tell an Eiffel story.
</p>
<h3><i>Before you start</i></h3>
[To be completed]


<h2><a name="tools">5. Tools and ports to new platforms</a></h2>
<p>Developers love tools. Even a small tool contribution can make a real difference.
You can produce tools at many levels:</p>

<ul>
	<li> 
		The keystone of Eiffel development is the <strong>EiffelStudio</strong> IDE (integrated development environment). EiffelStudio is big, but that has not detracted many open-source contributors from making significant additions. Thanks to Eiffel’s clear structuring mechanism, even a newcomer can dive into the system, find his or her way around, and make a contribution.
	</li>
	<li>
		Developers also rely on many smaller <strong>utilities</strong>. If you prefer to start with something more modest than the full EiffelStudio, look at the many smaller tools that play a big practical role (Iron, compile_all, syntax_updater and others).
	</li>
</ul>
<p>A related area is to <strong>port</strong> Eiffel to new platforms. The Eiffel compilation technology is highly portable; if you are aware of a new processor or operating system on which Eiffel is not yet available, you can produce the first Eiffel implementation for it.
</p>

<h3><i>Before you start</i></h3>
<p>EiffelStudio: numerous people have expressed wishes regarding EiffelStudio functionalities. See the list at <a href="https://dev.eiffel.com/EiffelStudio_Wish_List">EiffelStudio Wish List</a> and see if your proposed features have already been recorded. Feel free to add to the list, and to set on implementing mechanisms that will help the community.
Other tools: [To be completed]
Porting Eiffel: [To be completed]
</p>

<h2><a name="testing">6. Testing and  bug fixing</a></h2>
<p>Eiffel always requires improvement:</p>
<ul>
	<li>Even if you are not directly contributing software or documentation, you can help by <strong>testing</strong> the technology, particularly new features, new platforms, and combinations of features.</li>
	<li>When you encounter a problem, do not just look for a workaround, but look around for previous reports if any, and if the problem has not been documented fill in a bug report. This is the best way to ensure that the problem is corrected.</li>
	<li>There is always, of course, the possibility of <strong>contributing a fix</strong> yourself. But just reporting mishaps is already a significant contribution.</li>
	<li>Beyond bugs, <strong>feedback</strong> on Eiffel mechanisms, their use and their possible improvements, is always helpful</li>
</ul>
<h3><i>Before you start</i></h3>
[To be completed]


<p>
It’s not only the environment but the language itself! Eiffel is the property of its community. The evolution of the language is managed by a standards committee (TC49-TG4) within the Ecma international standards organization, leading to an official ISO (International Standards Organization) standard. The committee is working constantly to develop Eiffel further in line with the strong methodological principles that are the hallmark of Eiffel. Any organization can  become a member of Ecma, and other possibilities (such as observer) are available. If you have ideas on where the language should go, get involved!</p>

<h2><a name="everything">7. Everything else</a></h2>
<p>The above list is far from exhaustive. There are many other ways to contribute, many of them requiring only a few minutes now and then:</p>
<ul>
	<li>Posting about Eiffel on social networks.</li>
	<li>Telling your friends and colleagues about Eiffel.</li>
	<li>If you are an educator, using Eiffel for your classes (check the introductory programming text)</li>
	<li>Helping novices and others on the Eiffel mailing list and other forums</li>
	<li>Plus everything we have not thought of!</liA>
</ul>
<h3><i>Before you start</i></h3>
[Eiffel mailing list]

