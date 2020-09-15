    <!-- Template: checkout.tpl -->
    <div class="sr-root" id="stripe-box">
      <div class="sr-main">
        <header class="sr-header">
          <div class="sr-header__logo"></div>
		  <h2>{htmlentities}{$title/}{/htmlentities}</h2>
        </header>
        <div class="sr-payment-summary payment-view">
          <h1 class="order-amount">{htmlentities}{$checkout_price/}{/htmlentities}</h1>
          <h4>Subscribe to {htmlentities}{$checkout_title/}{/htmlentities}</h4>
        </div>
        <form>
          <div class="sr-payment-form payment-view">
            <div class="sr-form-row">
              <div class="sr-combo-inputs">
                <div class="sr-combo-inputs-row">
				  <div class="user-contact">
				  <h3>User Contact</h3>
				  <label for="customer-email">Email address</label>
                  <input
                    type="text"
					required="required"
                    id="customer-email"
                    placeholder="Email"
                    autocomplete="cardholder"
                    class="sr-input"
                    value="{htmlentities}{$customer_email/}{/htmlentities}"
                  />
				  <label for="customer-name">Name (first, last)</label>
                  <input
                    type="text"
                    id="customer-name"
                    placeholder="Name"
                    class="sr-input"
                    value="{htmlentities}{$customer_name/}{/htmlentities}"
                  />
				  <label for="customer-phone">Phone (optional)</label>
				  <input
                    type="text"
					required="required"
                    id="customer-phone"
                    placeholder="Phone"
                    class="sr-input"
                    value="{htmlentities}{$customer_phone/}{/htmlentities}"
                  />
				  </div>
				</div>
                <div class="sr-combo-inputs-row">
{unless condition="$checkout_type ~ 'onetime'"}
				  <div class="user-information">
				  <h3>User information</h3>
				  <label for="customer-address-line1">Street address:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-line1"
                    placeholder="Street #1"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_street1/}{/htmlentities}"
                  />
                  <input
                    type="text"
                    id="customer-address-line2"
                    placeholder="Street #2"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_street2/}{/htmlentities}"
                  />
				  <label for="customer-address-city">City:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-city"
                    placeholder="City"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_city/}{/htmlentities}"
                  />
				  <label for="customer-address-postal-code">Postal code/ZIP:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-postal-code"
                    placeholder="Postal code"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_postal_code/}{/htmlentities}"
                  />
				  <label for="customer-address-state">State/Region:</label>
                  <input
                    type="text"
					required="required"
                    id="customer-address-state"
                    placeholder="State"
                    class="sr-input"
                    value="{htmlentities}{$customer_address_state/}{/htmlentities}"
                  />
				  <label for="customer-address-country">Country:</label>
					<select name="customer-address-country" 
					  required="required"
					  id="customer-address-country"
                      class="sr-input"
					>
						<option value="">...</option>
						<option value="AF" {if condition="$customer_address_country ~ 'AF'"}selected="selected"{/if}>Afghanistan</option>
						<option value="AL" {if condition="$customer_address_country ~ 'AL'"}selected="selected"{/if}>Albania</option>
						<option value="DZ" {if condition="$customer_address_country ~ 'DZ'"}selected="selected"{/if}>Algeria</option>
						<option value="AD" {if condition="$customer_address_country ~ 'AD'"}selected="selected"{/if}>Andorra</option>
						<option value="AO" {if condition="$customer_address_country ~ 'AO'"}selected="selected"{/if}>Angola</option>
						<option value="AG" {if condition="$customer_address_country ~ 'AG'"}selected="selected"{/if}>Antigua and Barbuda</option>
						<option value="AR" {if condition="$customer_address_country ~ 'AR'"}selected="selected"{/if}>Argentina</option>
						<option value="AM" {if condition="$customer_address_country ~ 'AM'"}selected="selected"{/if}>Armenia</option>
						<option value="AU" {if condition="$customer_address_country ~ 'AU'"}selected="selected"{/if}>Australia</option>
						<option value="AT" {if condition="$customer_address_country ~ 'AT'"}selected="selected"{/if}>Austria</option>
						<option value="AZ" {if condition="$customer_address_country ~ 'AZ'"}selected="selected"{/if}>Azerbaijan</option>
						<option value="BS" {if condition="$customer_address_country ~ 'BS'"}selected="selected"{/if}>Bahamas</option>
						<option value="BH" {if condition="$customer_address_country ~ 'BH'"}selected="selected"{/if}>Bahrain</option>
						<option value="BD" {if condition="$customer_address_country ~ 'BD'"}selected="selected"{/if}>Bangladesh</option>
						<option value="BB" {if condition="$customer_address_country ~ 'BB'"}selected="selected"{/if}>Barbados</option>
						<option value="BY" {if condition="$customer_address_country ~ 'BY'"}selected="selected"{/if}>Belarus</option>
						<option value="BE" {if condition="$customer_address_country ~ 'BE'"}selected="selected"{/if}>Belgium</option>
						<option value="BZ" {if condition="$customer_address_country ~ 'BZ'"}selected="selected"{/if}>Belize</option>
						<option value="BJ" {if condition="$customer_address_country ~ 'BJ'"}selected="selected"{/if}>Benin</option>
						<option value="BT" {if condition="$customer_address_country ~ 'BT'"}selected="selected"{/if}>Bhutan</option>
						<option value="BO" {if condition="$customer_address_country ~ 'BO'"}selected="selected"{/if}>Bolivia (Plurinational State of)</option>
						<option value="BA" {if condition="$customer_address_country ~ 'BA'"}selected="selected"{/if}>Bosnia and Herzegovina</option>
						<option value="BW" {if condition="$customer_address_country ~ 'BW'"}selected="selected"{/if}>Botswana</option>
						<option value="BR" {if condition="$customer_address_country ~ 'BR'"}selected="selected"{/if}>Brazil</option>
						<option value="BN" {if condition="$customer_address_country ~ 'BN'"}selected="selected"{/if}>Brunei Darussalam</option>
						<option value="BG" {if condition="$customer_address_country ~ 'BG'"}selected="selected"{/if}>Bulgaria</option>
						<option value="BF" {if condition="$customer_address_country ~ 'BF'"}selected="selected"{/if}>Burkina Faso</option>
						<option value="BI" {if condition="$customer_address_country ~ 'BI'"}selected="selected"{/if}>Burundi</option>
						<option value="CV" {if condition="$customer_address_country ~ 'CV'"}selected="selected"{/if}>Cabo Verde</option>
						<option value="KH" {if condition="$customer_address_country ~ 'KH'"}selected="selected"{/if}>Cambodia</option>
						<option value="CM" {if condition="$customer_address_country ~ 'CM'"}selected="selected"{/if}>Cameroon</option>
						<option value="CA" {if condition="$customer_address_country ~ 'CA'"}selected="selected"{/if}>Canada</option>
						<option value="CF" {if condition="$customer_address_country ~ 'CF'"}selected="selected"{/if}>Central African Republic</option>
						<option value="TD" {if condition="$customer_address_country ~ 'TD'"}selected="selected"{/if}>Chad</option>
						<option value="CL" {if condition="$customer_address_country ~ 'CL'"}selected="selected"{/if}>Chile</option>
						<option value="CN" {if condition="$customer_address_country ~ 'CN'"}selected="selected"{/if}>China</option>
						<option value="CO" {if condition="$customer_address_country ~ 'CO'"}selected="selected"{/if}>Colombia</option>
						<option value="KM" {if condition="$customer_address_country ~ 'KM'"}selected="selected"{/if}>Comoros</option>
						<option value="CG" {if condition="$customer_address_country ~ 'CG'"}selected="selected"{/if}>Congo</option>
						<option value="CD" {if condition="$customer_address_country ~ 'CD'"}selected="selected"{/if}>Congo, Democratic Republic of the</option>
						<option value="CR" {if condition="$customer_address_country ~ 'CR'"}selected="selected"{/if}>Costa Rica</option>
						<option value="CI" {if condition="$customer_address_country ~ 'CI'"}selected="selected"{/if}>Côte d'Ivoire</option>
						<option value="HR" {if condition="$customer_address_country ~ 'HR'"}selected="selected"{/if}>Croatia</option>
						<option value="CU" {if condition="$customer_address_country ~ 'CU'"}selected="selected"{/if}>Cuba</option>
						<option value="CY" {if condition="$customer_address_country ~ 'CY'"}selected="selected"{/if}>Cyprus</option>
						<option value="CZ" {if condition="$customer_address_country ~ 'CZ'"}selected="selected"{/if}>Czechia</option>
						<option value="DK" {if condition="$customer_address_country ~ 'DK'"}selected="selected"{/if}>Denmark</option>
						<option value="DJ" {if condition="$customer_address_country ~ 'DJ'"}selected="selected"{/if}>Djibouti</option>
						<option value="DM" {if condition="$customer_address_country ~ 'DM'"}selected="selected"{/if}>Dominica</option>
						<option value="DO" {if condition="$customer_address_country ~ 'DO'"}selected="selected"{/if}>Dominican Republic</option>
						<option value="EC" {if condition="$customer_address_country ~ 'EC'"}selected="selected"{/if}>Ecuador</option>
						<option value="EG" {if condition="$customer_address_country ~ 'EG'"}selected="selected"{/if}>Egypt</option>
						<option value="SV" {if condition="$customer_address_country ~ 'SV'"}selected="selected"{/if}>El Salvador</option>
						<option value="GQ" {if condition="$customer_address_country ~ 'GQ'"}selected="selected"{/if}>Equatorial Guinea</option>
						<option value="ER" {if condition="$customer_address_country ~ 'ER'"}selected="selected"{/if}>Eritrea</option>
						<option value="EE" {if condition="$customer_address_country ~ 'EE'"}selected="selected"{/if}>Estonia</option>
						<option value="SZ" {if condition="$customer_address_country ~ 'SZ'"}selected="selected"{/if}>Eswatini</option>
						<option value="ET" {if condition="$customer_address_country ~ 'ET'"}selected="selected"{/if}>Ethiopia</option>
						<option value="FJ" {if condition="$customer_address_country ~ 'FJ'"}selected="selected"{/if}>Fiji</option>
						<option value="FI" {if condition="$customer_address_country ~ 'FI'"}selected="selected"{/if}>Finland</option>
						<option value="FR" {if condition="$customer_address_country ~ 'FR'"}selected="selected"{/if}>France</option>
						<option value="GA" {if condition="$customer_address_country ~ 'GA'"}selected="selected"{/if}>Gabon</option>
						<option value="GM" {if condition="$customer_address_country ~ 'GM'"}selected="selected"{/if}>Gambia</option>
						<option value="GE" {if condition="$customer_address_country ~ 'GE'"}selected="selected"{/if}>Georgia</option>
						<option value="DE" {if condition="$customer_address_country ~ 'DE'"}selected="selected"{/if}>Germany</option>
						<option value="GH" {if condition="$customer_address_country ~ 'GH'"}selected="selected"{/if}>Ghana</option>
						<option value="GR" {if condition="$customer_address_country ~ 'GR'"}selected="selected"{/if}>Greece</option>
						<option value="GD" {if condition="$customer_address_country ~ 'GD'"}selected="selected"{/if}>Grenada</option>
						<option value="GT" {if condition="$customer_address_country ~ 'GT'"}selected="selected"{/if}>Guatemala</option>
						<option value="GN" {if condition="$customer_address_country ~ 'GN'"}selected="selected"{/if}>Guinea</option>
						<option value="GW" {if condition="$customer_address_country ~ 'GW'"}selected="selected"{/if}>Guinea-Bissau</option>
						<option value="GY" {if condition="$customer_address_country ~ 'GY'"}selected="selected"{/if}>Guyana</option>
						<option value="HT" {if condition="$customer_address_country ~ 'HT'"}selected="selected"{/if}>Haiti</option>
						<option value="HN" {if condition="$customer_address_country ~ 'HN'"}selected="selected"{/if}>Honduras</option>
						<option value="HU" {if condition="$customer_address_country ~ 'HU'"}selected="selected"{/if}>Hungary</option>
						<option value="IS" {if condition="$customer_address_country ~ 'IS'"}selected="selected"{/if}>Iceland</option>
						<option value="IN" {if condition="$customer_address_country ~ 'IN'"}selected="selected"{/if}>India</option>
						<option value="ID" {if condition="$customer_address_country ~ 'ID'"}selected="selected"{/if}>Indonesia</option>
						<option value="IR" {if condition="$customer_address_country ~ 'IR'"}selected="selected"{/if}>Iran (Islamic Republic of)</option>
						<option value="IQ" {if condition="$customer_address_country ~ 'IQ'"}selected="selected"{/if}>Iraq</option>
						<option value="IE" {if condition="$customer_address_country ~ 'IE'"}selected="selected"{/if}>Ireland</option>
						<option value="IL" {if condition="$customer_address_country ~ 'IL'"}selected="selected"{/if}>Israel</option>
						<option value="IT" {if condition="$customer_address_country ~ 'IT'"}selected="selected"{/if}>Italy</option>
						<option value="JM" {if condition="$customer_address_country ~ 'JM'"}selected="selected"{/if}>Jamaica</option>
						<option value="JP" {if condition="$customer_address_country ~ 'JP'"}selected="selected"{/if}>Japan</option>
						<option value="JO" {if condition="$customer_address_country ~ 'JO'"}selected="selected"{/if}>Jordan</option>
						<option value="KZ" {if condition="$customer_address_country ~ 'KZ'"}selected="selected"{/if}>Kazakhstan</option>
						<option value="KE" {if condition="$customer_address_country ~ 'KE'"}selected="selected"{/if}>Kenya</option>
						<option value="KI" {if condition="$customer_address_country ~ 'KI'"}selected="selected"{/if}>Kiribati</option>
						<option value="KP" {if condition="$customer_address_country ~ 'KP'"}selected="selected"{/if}>Korea (Democratic People's Republic of)</option>
						<option value="KR" {if condition="$customer_address_country ~ 'KR'"}selected="selected"{/if}>Korea, Republic of</option>
						<option value="KW" {if condition="$customer_address_country ~ 'KW'"}selected="selected"{/if}>Kuwait</option>
						<option value="KG" {if condition="$customer_address_country ~ 'KG'"}selected="selected"{/if}>Kyrgyzstan</option>
						<option value="LA" {if condition="$customer_address_country ~ 'LA'"}selected="selected"{/if}>Lao People's Democratic Republic</option>
						<option value="LV" {if condition="$customer_address_country ~ 'LV'"}selected="selected"{/if}>Latvia</option>
						<option value="LB" {if condition="$customer_address_country ~ 'LB'"}selected="selected"{/if}>Lebanon</option>
						<option value="LS" {if condition="$customer_address_country ~ 'LS'"}selected="selected"{/if}>Lesotho</option>
						<option value="LR" {if condition="$customer_address_country ~ 'LR'"}selected="selected"{/if}>Liberia</option>
						<option value="LY" {if condition="$customer_address_country ~ 'LY'"}selected="selected"{/if}>Libya</option>
						<option value="LI" {if condition="$customer_address_country ~ 'LI'"}selected="selected"{/if}>Liechtenstein</option>
						<option value="LT" {if condition="$customer_address_country ~ 'LT'"}selected="selected"{/if}>Lithuania</option>
						<option value="LU" {if condition="$customer_address_country ~ 'LU'"}selected="selected"{/if}>Luxembourg</option>
						<option value="MG" {if condition="$customer_address_country ~ 'MG'"}selected="selected"{/if}>Madagascar</option>
						<option value="MW" {if condition="$customer_address_country ~ 'MW'"}selected="selected"{/if}>Malawi</option>
						<option value="MY" {if condition="$customer_address_country ~ 'MY'"}selected="selected"{/if}>Malaysia</option>
						<option value="MV" {if condition="$customer_address_country ~ 'MV'"}selected="selected"{/if}>Maldives</option>
						<option value="ML" {if condition="$customer_address_country ~ 'ML'"}selected="selected"{/if}>Mali</option>
						<option value="MT" {if condition="$customer_address_country ~ 'MT'"}selected="selected"{/if}>Malta</option>
						<option value="MH" {if condition="$customer_address_country ~ 'MH'"}selected="selected"{/if}>Marshall Islands</option>
						<option value="MR" {if condition="$customer_address_country ~ 'MR'"}selected="selected"{/if}>Mauritania</option>
						<option value="MU" {if condition="$customer_address_country ~ 'MU'"}selected="selected"{/if}>Mauritius</option>
						<option value="MX" {if condition="$customer_address_country ~ 'MX'"}selected="selected"{/if}>Mexico</option>
						<option value="FM" {if condition="$customer_address_country ~ 'FM'"}selected="selected"{/if}>Micronesia (Federated States of)</option>
						<option value="MD" {if condition="$customer_address_country ~ 'MD'"}selected="selected"{/if}>Moldova, Republic of</option>
						<option value="MC" {if condition="$customer_address_country ~ 'MC'"}selected="selected"{/if}>Monaco</option>
						<option value="MN" {if condition="$customer_address_country ~ 'MN'"}selected="selected"{/if}>Mongolia</option>
						<option value="ME" {if condition="$customer_address_country ~ 'ME'"}selected="selected"{/if}>Montenegro</option>
						<option value="MA" {if condition="$customer_address_country ~ 'MA'"}selected="selected"{/if}>Morocco</option>
						<option value="MZ" {if condition="$customer_address_country ~ 'MZ'"}selected="selected"{/if}>Mozambique</option>
						<option value="MM" {if condition="$customer_address_country ~ 'MM'"}selected="selected"{/if}>Myanmar</option>
						<option value="NA" {if condition="$customer_address_country ~ 'NA'"}selected="selected"{/if}>Namibia</option>
						<option value="NR" {if condition="$customer_address_country ~ 'NR'"}selected="selected"{/if}>Nauru</option>
						<option value="NP" {if condition="$customer_address_country ~ 'NP'"}selected="selected"{/if}>Nepal</option>
						<option value="NL" {if condition="$customer_address_country ~ 'NL'"}selected="selected"{/if}>Netherlands</option>
						<option value="NZ" {if condition="$customer_address_country ~ 'NZ'"}selected="selected"{/if}>New Zealand</option>
						<option value="NI" {if condition="$customer_address_country ~ 'NI'"}selected="selected"{/if}>Nicaragua</option>
						<option value="NE" {if condition="$customer_address_country ~ 'NE'"}selected="selected"{/if}>Niger</option>
						<option value="NG" {if condition="$customer_address_country ~ 'NG'"}selected="selected"{/if}>Nigeria</option>
						<option value="MK" {if condition="$customer_address_country ~ 'MK'"}selected="selected"{/if}>North Macedonia</option>
						<option value="NO" {if condition="$customer_address_country ~ 'NO'"}selected="selected"{/if}>Norway</option>
						<option value="OM" {if condition="$customer_address_country ~ 'OM'"}selected="selected"{/if}>Oman</option>
						<option value="PK" {if condition="$customer_address_country ~ 'PK'"}selected="selected"{/if}>Pakistan</option>
						<option value="PW" {if condition="$customer_address_country ~ 'PW'"}selected="selected"{/if}>Palau</option>
						<option value="PA" {if condition="$customer_address_country ~ 'PA'"}selected="selected"{/if}>Panama</option>
						<option value="PG" {if condition="$customer_address_country ~ 'PG'"}selected="selected"{/if}>Papua New Guinea</option>
						<option value="PY" {if condition="$customer_address_country ~ 'PY'"}selected="selected"{/if}>Paraguay</option>
						<option value="PE" {if condition="$customer_address_country ~ 'PE'"}selected="selected"{/if}>Peru</option>
						<option value="PH" {if condition="$customer_address_country ~ 'PH'"}selected="selected"{/if}>Philippines</option>
						<option value="PL" {if condition="$customer_address_country ~ 'PL'"}selected="selected"{/if}>Poland</option>
						<option value="PT" {if condition="$customer_address_country ~ 'PT'"}selected="selected"{/if}>Portugal</option>
						<option value="QA" {if condition="$customer_address_country ~ 'QA'"}selected="selected"{/if}>Qatar</option>
						<option value="RO" {if condition="$customer_address_country ~ 'RO'"}selected="selected"{/if}>Romania</option>
						<option value="RU" {if condition="$customer_address_country ~ 'RU'"}selected="selected"{/if}>Russian Federation</option>
						<option value="RW" {if condition="$customer_address_country ~ 'RW'"}selected="selected"{/if}>Rwanda</option>
						<option value="KN" {if condition="$customer_address_country ~ 'KN'"}selected="selected"{/if}>Saint Kitts and Nevis</option>
						<option value="LC" {if condition="$customer_address_country ~ 'LC'"}selected="selected"{/if}>Saint Lucia</option>
						<option value="VC" {if condition="$customer_address_country ~ 'VC'"}selected="selected"{/if}>Saint Vincent and the Grenadines</option>
						<option value="WS" {if condition="$customer_address_country ~ 'WS'"}selected="selected"{/if}>Samoa</option>
						<option value="SM" {if condition="$customer_address_country ~ 'SM'"}selected="selected"{/if}>San Marino</option>
						<option value="ST" {if condition="$customer_address_country ~ 'ST'"}selected="selected"{/if}>Sao Tome and Principe</option>
						<option value="SA" {if condition="$customer_address_country ~ 'SA'"}selected="selected"{/if}>Saudi Arabia</option>
						<option value="SN" {if condition="$customer_address_country ~ 'SN'"}selected="selected"{/if}>Senegal</option>
						<option value="RS" {if condition="$customer_address_country ~ 'RS'"}selected="selected"{/if}>Serbia</option>
						<option value="SC" {if condition="$customer_address_country ~ 'SC'"}selected="selected"{/if}>Seychelles</option>
						<option value="SL" {if condition="$customer_address_country ~ 'SL'"}selected="selected"{/if}>Sierra Leone</option>
						<option value="SG" {if condition="$customer_address_country ~ 'SG'"}selected="selected"{/if}>Singapore</option>
						<option value="SK" {if condition="$customer_address_country ~ 'SK'"}selected="selected"{/if}>Slovakia</option>
						<option value="SI" {if condition="$customer_address_country ~ 'SI'"}selected="selected"{/if}>Slovenia</option>
						<option value="SB" {if condition="$customer_address_country ~ 'SB'"}selected="selected"{/if}>Solomon Islands</option>
						<option value="SO" {if condition="$customer_address_country ~ 'SO'"}selected="selected"{/if}>Somalia</option>
						<option value="ZA" {if condition="$customer_address_country ~ 'ZA'"}selected="selected"{/if}>South Africa</option>
						<option value="SS" {if condition="$customer_address_country ~ 'SS'"}selected="selected"{/if}>South Sudan</option>
						<option value="ES" {if condition="$customer_address_country ~ 'ES'"}selected="selected"{/if}>Spain</option>
						<option value="LK" {if condition="$customer_address_country ~ 'LK'"}selected="selected"{/if}>Sri Lanka</option>
						<option value="SD" {if condition="$customer_address_country ~ 'SD'"}selected="selected"{/if}>Sudan</option>
						<option value="SR" {if condition="$customer_address_country ~ 'SR'"}selected="selected"{/if}>Suriname</option>
						<option value="SE" {if condition="$customer_address_country ~ 'SE'"}selected="selected"{/if}>Sweden</option>
						<option value="CH" {if condition="$customer_address_country ~ 'CH'"}selected="selected"{/if}>Switzerland</option>
						<option value="SY" {if condition="$customer_address_country ~ 'SY'"}selected="selected"{/if}>Syrian Arab Republic</option>
						<option value="TJ" {if condition="$customer_address_country ~ 'TJ'"}selected="selected"{/if}>Tajikistan</option>
						<option value="TZ" {if condition="$customer_address_country ~ 'TZ'"}selected="selected"{/if}>Tanzania, United Republic of</option>
						<option value="TH" {if condition="$customer_address_country ~ 'TH'"}selected="selected"{/if}>Thailand</option>
						<option value="TL" {if condition="$customer_address_country ~ 'TL'"}selected="selected"{/if}>Timor-Leste</option>
						<option value="TG" {if condition="$customer_address_country ~ 'TG'"}selected="selected"{/if}>Togo</option>
						<option value="TO" {if condition="$customer_address_country ~ 'TO'"}selected="selected"{/if}>Tonga</option>
						<option value="TT" {if condition="$customer_address_country ~ 'TT'"}selected="selected"{/if}>Trinidad and Tobago</option>
						<option value="TN" {if condition="$customer_address_country ~ 'TN'"}selected="selected"{/if}>Tunisia</option>
						<option value="TR" {if condition="$customer_address_country ~ 'TR'"}selected="selected"{/if}>Turkey</option>
						<option value="TM" {if condition="$customer_address_country ~ 'TM'"}selected="selected"{/if}>Turkmenistan</option>
						<option value="TV" {if condition="$customer_address_country ~ 'TV'"}selected="selected"{/if}>Tuvalu</option>
						<option value="UG" {if condition="$customer_address_country ~ 'UG'"}selected="selected"{/if}>Uganda</option>
						<option value="UA" {if condition="$customer_address_country ~ 'UA'"}selected="selected"{/if}>Ukraine</option>
						<option value="AE" {if condition="$customer_address_country ~ 'AE'"}selected="selected"{/if}>United Arab Emirates</option>
						<option value="GB" {if condition="$customer_address_country ~ 'GB'"}selected="selected"{/if}>United Kingdom of Great Britain and Northern Ireland</option>
						<option value="US" {if condition="$customer_address_country ~ 'US'"}selected="selected"{/if}>United States of America</option>
						<option value="UY" {if condition="$customer_address_country ~ 'UY'"}selected="selected"{/if}>Uruguay</option>
						<option value="UZ" {if condition="$customer_address_country ~ 'UZ'"}selected="selected"{/if}>Uzbekistan</option>
						<option value="VU" {if condition="$customer_address_country ~ 'VU'"}selected="selected"{/if}>Vanuatu</option>
						<option value="VE" {if condition="$customer_address_country ~ 'VE'"}selected="selected"{/if}>Venezuela (Bolivarian Republic of)</option>
						<option value="VN" {if condition="$customer_address_country ~ 'VN'"}selected="selected"{/if}>Viet Nam</option>
						<option value="YE" {if condition="$customer_address_country ~ 'YE'"}selected="selected"{/if}>Yemen</option>
						<option value="ZM" {if condition="$customer_address_country ~ 'ZM'"}selected="selected"{/if}>Zambia</option>
						<option value="ZW" {if condition="$customer_address_country ~ 'ZW'"}selected="selected"{/if}>Zimbabwe</option>
					</select>
				  </label>
				  </div> <!-- info -->
{/unless}
                  <input
                    type="hidden"
                    id="items"
                    value="{htmlentities}{$checkout_items/}{/htmlentities}"
                  />
                </div>
                <div class="sr-combo-inputs-row">
				  <div class="payment-details" style="width: 100%;">
  				  <h3>Payment details</h3>
				  </div>
				</div>
                <div class="sr-combo-inputs-row">
                  <div class="sr-input sr-card-element" id="card-element"></div>
                </div>
              </div>
              <div class="sr-field-error" id="card-errors" role="alert"></div>
            </div>
            <button id="submit">
              <div id="spinner" class="hidden"></div>
              <span id="button-text">Place Order</span>
            </button>
            <div class="sr-legal-text">
              Your card will be immediately charged
              <span class="order-total">{htmlentities}{$checkout_price/}{/htmlentities}</span>.
            </div>
          </div>
        </form>
        <div class="sr-payment-summary hidden completed-view">
          <h1>Your order is <span class="order-status"></span></h1>
        </div>
        <div class="sr-section hidden completed-view">
          <div class="sr-callout">
            <div class="order-summary"></div>
            <pre><code></code></pre>
          </div>
          <button onclick="window.location.href='/'">Back home</button>
        </div>
      </div>
    </div>

  <script defer>
    window.eStripeEltsModal.setup("{$stripe_host_url/}", document.getElementById("stripe-box"));
	{literal}window.eStripeEltsModal.create({ {/literal}
      currency: "USD",
      businessName: "{htmlentities}{$business_name/}{/htmlentities}",
      productTitle: "{htmlentities}{$checkout_title/}{/htmlentities}",
      productName: "{htmlentities}{$checkout_name/}{/htmlentities}",
      productCategory: "{htmlentities}{$checkout_category/}{/htmlentities}",
      customerEmail: "{htmlentities}{$customer_email/}{/htmlentities}",
      customerName: "{htmlentities}{$customer_name/}{/htmlentities}",
      checkoutItems: "{htmlentities}{$checkout_items/}{/htmlentities}",
      {if isset="$metadata"}metadata: {$metadata/},{/if}
      metadataOrderId: "{htmlentities}{$order_id/}{/htmlentities}"
	{literal} }); {/literal}
  </script>
