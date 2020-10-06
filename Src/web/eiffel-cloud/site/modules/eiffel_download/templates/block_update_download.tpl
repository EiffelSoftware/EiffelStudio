	<div class="download-box clearfix">
    <h1>Update Eiffel {htmlentities}{$download_channel/}{/htmlentities} Download </h1>
    <form method="post" action="{$site_url/}admin/eiffel_download/process/channel/{$download_channel/}" id="download-form" enctype="multipart/form-data">
        <label for="name">File: <span >Select the file</span></label>
         <input  name="uploaded_file" id="fileInput" type="file"  data-original-title="" title="" accept=".json">
        <input type="submit" value="Upload" class="submit-button" />
           <p class="req-field-desc"><span class="required">*</span>You can only upload a JSON file.</p>	
    </form>
 	</div>
