<h2 class="sub-header">PR# {$report.number/} {$report.synopsis/} </h2>
 
<details>
  <summary id="labels">Problem Report Summary</summary>
  <div class="row">
  <div class="col-lg-16">
       <div class="panel panel-primary">
              <div class="panel-heading">Problem Report Summary</div>
              <div class="panel-body">
  <div class="container">
      <!--form -->
      <div class="row">
       <div class="span8">
          <div class="row">   
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Submitter:</span> : <td>{$report.contact.name/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Category:</span> : <td>{$report.category.synopsis/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Priority:</span> : <td>{$report.priority.synopsis/}</td> </br>
              </div>
         </div>
         <div class="row">  
                <div class="col-lg-4 lightblue">
                  <span class="label label-info">Date:</span> : <td>{$report.submission_date/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Class:</span> : <td>{$report.report_class.synopsis/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                 <span class="label label-info">Severity:</span> : <td>{$report.severity.synopsis/}</td> </br>
             </div>
           </div>
          <div class="row">   
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Number:</span> : <td>{$report.number/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Release:</span> : <td>{$report.release/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Confidential:</span> : <td>{$report.confidential/}</td> </br>
             </div>
           </div>  
          <div class="row">      
             <div class="col-lg-4 lightblue">
                  <span class="label label-info">Status:</span> : <td>{$report.status.synopsis/}</td> </br>
               </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Responsible:</span> : <td></td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info">Environment:</span> : <td>{$report.environment/}</td> </br>
              </div>
           </div>
            <div class="row">
                <div class="col-lg-4 lightblue">
                  <span class="label label-info">Synopsys:</span> : <td>{$report.synopsis/}</td> </br>
                </div>
            </div>    

          <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-primary">
              <div class="panel-heading">Description</div>
              <div class="panel-body">{$report.description/}</div>
            </div>
          </div>
         </div>
          <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-primary">
              <div class="panel-heading">To Reproduce</div>
              <div class="panel-body">{$report.to_reproduce/}</div>
            </div>
          </div> 
         </div>  
        </div> <!-- span -->
      </div>
      <!--form -->
    </div>     

    </div>
    </div>
    </div>
    </div>        
</details>

<details>
  <summary id="labels"> Problem Report Interactions</summary>
  <div class="row">
  <div class="col-lg-16">
       <div class="panel panel-primary">
              <div class="panel-heading">Problem Report Summary</div>
              <div class="panel-body">
  <div class="container">
      <!--form -->
      <div class="row">
      <div class="span8">
                 
      {foreach from="$report.interactions" item="item"}
                    <div class="row">
                      <div class="col-lg-12">
                      <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="label label-info">From:</span> {$item.contact.name/}   <span class="label label-info">Date:</span>{$item.date/}    <span class="label label-info">Status:</span> {$item.status/}</div>
                        <div class="panel-body">{$item.content/} <br>
                                    {foreach from="$item.attachments" item="elem"}
                                         <div class="row">
                                         <div class="col-lg-8">
                                          <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <span class="label label-info">Attachment:</span> <a href="{$host/}/report_interaction/{$elem.id/}/{$elem.name/}"  download="{$elem.name/}">{$elem.name/}</a>   <span class="label label-info">Size:</span> {$elem.bytes_count/} </div>
                                          </div> 
                                         </div>
                                        </div>  
                                    {/foreach}

                        </div>      
            
                      </div>
                      </div> 
                    </div>  
                    
        {/foreach}
      <!--form -->
    </div>
    </div>     
    </div>

    </div>
    </div>
    </div>
    </div>        
</details>  
</div>