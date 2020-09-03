
<!DOCTYPE html>
<html lang="en-US">
<head>
	<title>Home | Eiffel Software - The Home of EiffelStudio-Test Page</title>
</head>
<body>
	<h3><strong>Download</strong> EiffelStudio Today</h3>
		<form action="{$host/}/download" method="POST" class="bootstrap-frm">
		<fieldset>
		<h3><strong>Tell us a bit about yourself</strong></h3>
								
		<label>
		    <span>First Name :</span>
		    <input id="first_name" type="text" name="first_name" placeholder="Your First Name" required/><br>
		</label>

		<label>
		    <span>Last Name :</span>
		    <input id="last_name" type="text" name="last_name" placeholder="Your Last Name" required/><br>
		</label>

		<label>
		    <span>Your Email :</span>
		    <input id="email" type="email" name="email" placeholder="Valid Email Address" required/><br>
		</label>
		<label>
		    <span>Your Company :</span>
		    <input id="company" type="text" name="company" placeholder="Company Name" /><br>
		</label>
		<label>
			<span>Title:</span>
				<select id="title" name="title">
					<option value="developer">Developer</option>
					<option value="project_manager">Project Manager</option>
					<option value="cio_cto">CIO/CTO</option>
					<option value="student">Student</option>
					<option value="professor">Professor</option>
					<option value="other">Other</option>
				</select></br>
		</label>	
		 <label>
		    <span>Platform :</span>
			 <select name="platform">
			    <option value="win64">Win64</option>    
			    <option value="windows">windows</option>   
			    <option value="windows-x86-64">windows-x86-64</option>    
			    <option value="windows-x86">windows-x86</option>  
			    <option value="solaris-x86">solaris-x86</option>    
			    <option value="solaris-x86-64">solaris-x86-64</option>  
			    <option value="solaris-sparc">solaris-sparc</option>  
			    <option value="solaris-sparc-64">solaris-sparc-64</option>    
			    <option value="openbsd-x86">openbsd-x86</option>    
			    <option value="openbsd-x86-64">openbsd-x86-64</option>  
			    <option value="macosx-x86-64">macosx-x86-64</option>    
			    <option value="linux-x86">linux-x86</option>    
			    <option value="linux-x86-64">linux-x86-64</option>
			    <option value="linux-sparc">linux-sparc</option>
			    <option value="linux-ppc">linux-ppc</option>
			    <option value="irix-mips">irix-mips</option>
			    <option value="irix-mips-64">irix-mips-64</option>
			    <option value="freebsd-x86">freebsd-x86</option>
			</select></br>
		</label>    

		 <label>
		    <span>Product :</span>
			 <select name="product">
			    <option value="eiffelstudio_standard">Standard</option>    
			    <option value="eiffelstudio_enterprise">Enterprise</option>    
			    <option value="eiffelstudio_branded">Branded</option>    
			</select></br>
		</label>    

		<label class="checkbox"><input type="checkbox" name="newsletter" value="newsletter"><label>Newsletter</label> </label><br>
		</fieldset>								
		<fieldset>	
		<label>
		    <span>&nbsp;</span> 
		    <input type="Submit" class="button" value="Send" formtarget="_top" /> 
		</label>
		</fieldset>  
									</form>                			
			        	</div>
</body>
</html>
