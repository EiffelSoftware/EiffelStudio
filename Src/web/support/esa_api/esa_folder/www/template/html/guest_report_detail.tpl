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
                  <span class="label label-info" itemprop="submitter">Submitter:</span> : <td>{$report.contact.name/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="category">Category:</span> : <td>{$report.category.synopsis/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="priority">Priority:</span> : <td>{$report.priority.synopsis/}</td> </br>
              </div>
         </div>
         <div class="row">  
                <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="date">Date:</span> : <td>{$report.submission_date/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="class">Class:</span> : <td>{$report.report_class.synopsis/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                 <span class="label label-info" itemprop="severity">Severity:</span> : <td>{$report.severity.synopsis/}</td> </br>
             </div>
           </div>
          <div class="row">   
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="report-number">Number:</span> : <td>{$report.number/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="release">Release:</span> : <td>{$report.release/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="confidential">Confidential:</span> : <td>{$report.confidential/}</td> </br>
             </div>
           </div>  
          <div class="row">      
             <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="status">Status:</span> : <td>{$report.status.synopsis/}</td> </br>
               </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="responsible">Responsible:</span> : <td></td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="environment">Environment:</span> : <td>{$report.environment/}</td> </br>
              </div>
           </div>
            <div class="row">
                <div class="col-lg-4 lightblue">
                  <span class="label label-info" itemprop="synopsis">Synopsis:</span> : <td>{$report.synopsis/}</td> </br>
                </div>
            </div>    

          <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-primary">
              <div class="panel-heading" itemprop="description">Description</div>
              <div class="panel-body">{$report.description/}</div>
            </div>
          </div>
         </div>
          <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-primary">
              <div class="panel-heading" itemprop="to-reproduce">To Reproduce</div>
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
                        <div class="panel-heading"> <span class="label label-info" itemprop="submitter">From:</span> {$item.contact.name/}   <span class="label label-info" itemprop="date">Date:</span>{$item.date/}    <span class="label label-info" itemprop="status">Status:</span> {$item.status/}</div>
                        <div class="panel-body">{$item.content/} <br>
                                    {foreach from="$item.attachments" item="elem"}
                                         <div class="row">
                                         <div class="col-lg-8">
                                          <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <span class="label label-info" itemprop="attachment">Attachment:</span> <a href="{$host/}/report_interaction/{$elem.id/}/{$elem.name/}"  download="{$elem.name/}">{$elem.name/}</a>   <span class="label label-info">Size:</span> {$elem.bytes_count/} </div>
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
        {if isset="$user"}
            <div class="btn-group">
                <a href="{$host/}/report_detail/{$report.number/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">
                    Add Interaction
                </a>
            </div> 
         {/if}
</div>