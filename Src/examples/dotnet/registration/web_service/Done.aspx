<%@ Assembly Name="registrationservice" %>
<%@ Import Namespace="RegistrationService" %>
<%@ Page Language="C#" %>

<HTML>
	<HEAD>
		<META http-EQUIV="Content-TyPe" CONTENT="text/html; charset=windows-1252">
		<TITLE>TOOLS USA 2000</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="usa.css">
		<SCRIPT RUNAT="SERVER">
			string clicked;
			void Back_Click( Object Source, EventArgs E )
			{
				clicked = "Yep";
				// Back to the registration form
				Navigate( "Registration.aspx" );
			}

		</SCRIPT>
	</HEAD>
	<BODY CELLSPACING="0" CELLPADDING="0" TOPMARGIN="0" LEFTMARGIN="0">
		<TABLE BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
			<TR>
				<TD WIDTH="17%" VALIGN="TOP" BGCOLOR="#006633">
					<TABLE BORDER="4" WIDTH="37%" VALIGN="TOP" BGCOLOR="#006633" CELLSPACING="0" CELLPADDING="0" BORDERCOLOR="#006633">
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">
								<P ALIGN="CENTER"><A HREF="http://www.tools-conferences.com"><IMG SRC="images/tools2000logo.jpg" BORDER="0" ALT="TOOLS Conferences home" ALIGN="LEFT" WIDTH="130" HEIGHT="70"></A>
								</P>
							</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">
								<A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa">TOOLS USA Home</A>
							</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/calls/committee.html">Comittee</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/keynotes.html">Keynotes</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/tutorials.html">Tutorials</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/intro_ot.html">Intro to OT</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/papers.html">Papers</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/schedule.html">Schedule</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/wet.html">WET</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/eiffel_summit/index.html">Eiffel Summit</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/calls/exhibit.html">Exhibit at TOOLS</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/sponsors.html">Sponsors</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/tools/usa/registration/index.html">Registration</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/sb.html">About Santa-Barbara</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/contact.html">Contact TOOLS!</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633"  VALIGN="BOTTOM">
								<CENTER>
									<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" HEIGHT="160">
										<TR>
											<TD WIDTH="100%" VALIGN="BOTTOM"><IMG BORDER="0" SRC="images/photo_pool.jpg" WIDTH="172" HEIGHT="138" align="BOTTOM"></TD>
										</TR>
									</TABLE>
								</CENTER>
							</TD>
						</TR>
					</TABLE>
				</TD>
				<TD WIDTH="83%" VALIGN="TOP">
					<TABLE BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
						<TR HEIGHT="29">
							<TD WIDTH="100%">
				                                <TABLE BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
									<TR HEIGHT=29>
										<TD WIDTH="6%" BGCOLOR="#006633" HEIGHT="29"></TD>
										<TD WIDTH="88%" BGCOLOR="#006633" HEIGHT="29" VALIGN=MIDDLE ALIGN=CENTER>
											<FONT FACE="Verdana, Arial, Helvetica" COLOR=#FFFFF><B>
												TOOLS USA 2000 - <I>Software Serving Society</I></B>
											</FONT>
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<TR HEIGHT = "36">
							<TD WIDTH="100%">
								<DIV ALIGN="CENTER">
									<TABLE BORDER="0" WIDTH="100%" CELLPADDING="0" CELLSPACING="0">
										<TR>
											<TD WIDTH="100%">
												<P ALIGN="CENTER"><FONT SIZE="5" COLOR="#006633">Registration Successful!</FONT></P>
											</TD>
										</TR>
									</TABLE>
								</DIV>
							</TD>
						</TR>
						<TR VALIGN="BOTTOM">
							<TD WIDTH="100%">
								<TABLE BORDER="0" WIDTH="99%" BGCOLOR="#FFFFCC" CELLSPACING="0" CELLPADDING="0" HEIGHT="90%" VALIGN="BOTTOM" ALIGN="CENTER">
									<TR>
										<TD>
											<BR><BR>
											<H6 CLASS="register">
												Thank you for your registration, we will see you in Santa-Barbara.
											</H6>
											<BR>
										</TD>
									</TR>
									<TR>
										<TD ALIGN="RIGHT">
											<H6 CLASS="register">
												The Tools Team.
											</H6>
											<BR><BR>
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
					<TABLE WIDTH="99%" BGCOLOR="#FFFFCC" BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="35" ALIGN="CENTER">
						<TR>
							<TD ALIGN="LEFT">
								<A HREF="Registration.aspx">Back</A><BR><BR>
							</TD>
							<TD ALIGN="RIGHT">
								<A HREF="Report.aspx">See Report</A><BR><BR>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
