
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature
	make is
		local
			code: CHARACTER
		do
			code := '%/1/'
			inspect code
			when '%/1/' then
				print ("1%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/1/' then
				print ("1%N")
			else
				print ("Wrong!%N")
			end

			code := '%/2/'
			inspect code
			when '%/2/' then
				print ("2%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/2/' then
				print ("2%N")
			else
				print ("Wrong!%N")
			end

			code := '%/3/'
			inspect code
			when '%/3/' then
				print ("3%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/3/' then
				print ("3%N")
			else
				print ("Wrong!%N")
			end

			code := '%/4/'
			inspect code
			when '%/4/' then
				print ("4%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/4/' then
				print ("4%N")
			else
				print ("Wrong!%N")
			end

			code := '%/5/'
			inspect code
			when '%/5/' then
				print ("5%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/5/' then
				print ("5%N")
			else
				print ("Wrong!%N")
			end

			code := '%/6/'
			inspect code
			when '%/6/' then
				print ("6%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/6/' then
				print ("6%N")
			else
				print ("Wrong!%N")
			end

			code := '%/7/'
			inspect code
			when '%/7/' then
				print ("7%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/7/' then
				print ("7%N")
			else
				print ("Wrong!%N")
			end

			code := '%/8/'
			inspect code
			when '%/8/' then
				print ("8%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/8/' then
				print ("8%N")
			else
				print ("Wrong!%N")
			end

			code := '%/9/'
			inspect code
			when '%/9/' then
				print ("9%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/9/' then
				print ("9%N")
			else
				print ("Wrong!%N")
			end

			code := '%/10/'
			inspect code
			when '%/10/' then
				print ("10%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/10/' then
				print ("10%N")
			else
				print ("Wrong!%N")
			end

			code := '%/11/'
			inspect code
			when '%/11/' then
				print ("11%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/11/' then
				print ("11%N")
			else
				print ("Wrong!%N")
			end

			code := '%/12/'
			inspect code
			when '%/12/' then
				print ("12%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/12/' then
				print ("12%N")
			else
				print ("Wrong!%N")
			end

			code := '%/13/'
			inspect code
			when '%/13/' then
				print ("13%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/13/' then
				print ("13%N")
			else
				print ("Wrong!%N")
			end

			code := '%/14/'
			inspect code
			when '%/14/' then
				print ("14%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/14/' then
				print ("14%N")
			else
				print ("Wrong!%N")
			end

			code := '%/15/'
			inspect code
			when '%/15/' then
				print ("15%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/15/' then
				print ("15%N")
			else
				print ("Wrong!%N")
			end

			code := '%/16/'
			inspect code
			when '%/16/' then
				print ("16%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/16/' then
				print ("16%N")
			else
				print ("Wrong!%N")
			end

			code := '%/17/'
			inspect code
			when '%/17/' then
				print ("17%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/17/' then
				print ("17%N")
			else
				print ("Wrong!%N")
			end

			code := '%/18/'
			inspect code
			when '%/18/' then
				print ("18%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/18/' then
				print ("18%N")
			else
				print ("Wrong!%N")
			end

			code := '%/19/'
			inspect code
			when '%/19/' then
				print ("19%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/19/' then
				print ("19%N")
			else
				print ("Wrong!%N")
			end

			code := '%/20/'
			inspect code
			when '%/20/' then
				print ("20%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/20/' then
				print ("20%N")
			else
				print ("Wrong!%N")
			end

			code := '%/21/'
			inspect code
			when '%/21/' then
				print ("21%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/21/' then
				print ("21%N")
			else
				print ("Wrong!%N")
			end

			code := '%/22/'
			inspect code
			when '%/22/' then
				print ("22%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/22/' then
				print ("22%N")
			else
				print ("Wrong!%N")
			end

			code := '%/23/'
			inspect code
			when '%/23/' then
				print ("23%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/23/' then
				print ("23%N")
			else
				print ("Wrong!%N")
			end

			code := '%/24/'
			inspect code
			when '%/24/' then
				print ("24%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/24/' then
				print ("24%N")
			else
				print ("Wrong!%N")
			end

			code := '%/25/'
			inspect code
			when '%/25/' then
				print ("25%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/25/' then
				print ("25%N")
			else
				print ("Wrong!%N")
			end

			code := '%/26/'
			inspect code
			when '%/26/' then
				print ("26%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/26/' then
				print ("26%N")
			else
				print ("Wrong!%N")
			end

			code := '%/27/'
			inspect code
			when '%/27/' then
				print ("27%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/27/' then
				print ("27%N")
			else
				print ("Wrong!%N")
			end

			code := '%/28/'
			inspect code
			when '%/28/' then
				print ("28%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/28/' then
				print ("28%N")
			else
				print ("Wrong!%N")
			end

			code := '%/29/'
			inspect code
			when '%/29/' then
				print ("29%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/29/' then
				print ("29%N")
			else
				print ("Wrong!%N")
			end

			code := '%/30/'
			inspect code
			when '%/30/' then
				print ("30%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/30/' then
				print ("30%N")
			else
				print ("Wrong!%N")
			end

			code := '%/31/'
			inspect code
			when '%/31/' then
				print ("31%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/31/' then
				print ("31%N")
			else
				print ("Wrong!%N")
			end

			code := '%/32/'
			inspect code
			when '%/32/' then
				print ("32%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/32/' then
				print ("32%N")
			else
				print ("Wrong!%N")
			end

			code := '%/33/'
			inspect code
			when '%/33/' then
				print ("33%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/33/' then
				print ("33%N")
			else
				print ("Wrong!%N")
			end

			code := '%/34/'
			inspect code
			when '%/34/' then
				print ("34%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/34/' then
				print ("34%N")
			else
				print ("Wrong!%N")
			end

			code := '%/35/'
			inspect code
			when '%/35/' then
				print ("35%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/35/' then
				print ("35%N")
			else
				print ("Wrong!%N")
			end

			code := '%/36/'
			inspect code
			when '%/36/' then
				print ("36%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/36/' then
				print ("36%N")
			else
				print ("Wrong!%N")
			end

			code := '%/37/'
			inspect code
			when '%/37/' then
				print ("37%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/37/' then
				print ("37%N")
			else
				print ("Wrong!%N")
			end

			code := '%/38/'
			inspect code
			when '%/38/' then
				print ("38%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/38/' then
				print ("38%N")
			else
				print ("Wrong!%N")
			end

			code := '%/39/'
			inspect code
			when '%/39/' then
				print ("39%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/39/' then
				print ("39%N")
			else
				print ("Wrong!%N")
			end

			code := '%/40/'
			inspect code
			when '%/40/' then
				print ("40%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/40/' then
				print ("40%N")
			else
				print ("Wrong!%N")
			end

			code := '%/41/'
			inspect code
			when '%/41/' then
				print ("41%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/41/' then
				print ("41%N")
			else
				print ("Wrong!%N")
			end

			code := '%/42/'
			inspect code
			when '%/42/' then
				print ("42%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/42/' then
				print ("42%N")
			else
				print ("Wrong!%N")
			end

			code := '%/43/'
			inspect code
			when '%/43/' then
				print ("43%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/43/' then
				print ("43%N")
			else
				print ("Wrong!%N")
			end

			code := '%/44/'
			inspect code
			when '%/44/' then
				print ("44%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/44/' then
				print ("44%N")
			else
				print ("Wrong!%N")
			end

			code := '%/45/'
			inspect code
			when '%/45/' then
				print ("45%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/45/' then
				print ("45%N")
			else
				print ("Wrong!%N")
			end

			code := '%/46/'
			inspect code
			when '%/46/' then
				print ("46%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/46/' then
				print ("46%N")
			else
				print ("Wrong!%N")
			end

			code := '%/47/'
			inspect code
			when '%/47/' then
				print ("47%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/47/' then
				print ("47%N")
			else
				print ("Wrong!%N")
			end

			code := '%/48/'
			inspect code
			when '%/48/' then
				print ("48%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/48/' then
				print ("48%N")
			else
				print ("Wrong!%N")
			end

			code := '%/49/'
			inspect code
			when '%/49/' then
				print ("49%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/49/' then
				print ("49%N")
			else
				print ("Wrong!%N")
			end

			code := '%/50/'
			inspect code
			when '%/50/' then
				print ("50%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/50/' then
				print ("50%N")
			else
				print ("Wrong!%N")
			end

			code := '%/51/'
			inspect code
			when '%/51/' then
				print ("51%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/51/' then
				print ("51%N")
			else
				print ("Wrong!%N")
			end

			code := '%/52/'
			inspect code
			when '%/52/' then
				print ("52%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/52/' then
				print ("52%N")
			else
				print ("Wrong!%N")
			end

			code := '%/53/'
			inspect code
			when '%/53/' then
				print ("53%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/53/' then
				print ("53%N")
			else
				print ("Wrong!%N")
			end

			code := '%/54/'
			inspect code
			when '%/54/' then
				print ("54%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/54/' then
				print ("54%N")
			else
				print ("Wrong!%N")
			end

			code := '%/55/'
			inspect code
			when '%/55/' then
				print ("55%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/55/' then
				print ("55%N")
			else
				print ("Wrong!%N")
			end

			code := '%/56/'
			inspect code
			when '%/56/' then
				print ("56%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/56/' then
				print ("56%N")
			else
				print ("Wrong!%N")
			end

			code := '%/57/'
			inspect code
			when '%/57/' then
				print ("57%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/57/' then
				print ("57%N")
			else
				print ("Wrong!%N")
			end

			code := '%/58/'
			inspect code
			when '%/58/' then
				print ("58%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/58/' then
				print ("58%N")
			else
				print ("Wrong!%N")
			end

			code := '%/59/'
			inspect code
			when '%/59/' then
				print ("59%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/59/' then
				print ("59%N")
			else
				print ("Wrong!%N")
			end

			code := '%/60/'
			inspect code
			when '%/60/' then
				print ("60%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/60/' then
				print ("60%N")
			else
				print ("Wrong!%N")
			end

			code := '%/61/'
			inspect code
			when '%/61/' then
				print ("61%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/61/' then
				print ("61%N")
			else
				print ("Wrong!%N")
			end

			code := '%/62/'
			inspect code
			when '%/62/' then
				print ("62%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/62/' then
				print ("62%N")
			else
				print ("Wrong!%N")
			end

			code := '%/63/'
			inspect code
			when '%/63/' then
				print ("63%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/63/' then
				print ("63%N")
			else
				print ("Wrong!%N")
			end

			code := '%/64/'
			inspect code
			when '%/64/' then
				print ("64%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/64/' then
				print ("64%N")
			else
				print ("Wrong!%N")
			end

			code := '%/65/'
			inspect code
			when '%/65/' then
				print ("65%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/65/' then
				print ("65%N")
			else
				print ("Wrong!%N")
			end

			code := '%/66/'
			inspect code
			when '%/66/' then
				print ("66%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/66/' then
				print ("66%N")
			else
				print ("Wrong!%N")
			end

			code := '%/67/'
			inspect code
			when '%/67/' then
				print ("67%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/67/' then
				print ("67%N")
			else
				print ("Wrong!%N")
			end

			code := '%/68/'
			inspect code
			when '%/68/' then
				print ("68%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/68/' then
				print ("68%N")
			else
				print ("Wrong!%N")
			end

			code := '%/69/'
			inspect code
			when '%/69/' then
				print ("69%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/69/' then
				print ("69%N")
			else
				print ("Wrong!%N")
			end

			code := '%/70/'
			inspect code
			when '%/70/' then
				print ("70%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/70/' then
				print ("70%N")
			else
				print ("Wrong!%N")
			end

			code := '%/71/'
			inspect code
			when '%/71/' then
				print ("71%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/71/' then
				print ("71%N")
			else
				print ("Wrong!%N")
			end

			code := '%/72/'
			inspect code
			when '%/72/' then
				print ("72%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/72/' then
				print ("72%N")
			else
				print ("Wrong!%N")
			end

			code := '%/73/'
			inspect code
			when '%/73/' then
				print ("73%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/73/' then
				print ("73%N")
			else
				print ("Wrong!%N")
			end

			code := '%/74/'
			inspect code
			when '%/74/' then
				print ("74%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/74/' then
				print ("74%N")
			else
				print ("Wrong!%N")
			end

			code := '%/75/'
			inspect code
			when '%/75/' then
				print ("75%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/75/' then
				print ("75%N")
			else
				print ("Wrong!%N")
			end

			code := '%/76/'
			inspect code
			when '%/76/' then
				print ("76%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/76/' then
				print ("76%N")
			else
				print ("Wrong!%N")
			end

			code := '%/77/'
			inspect code
			when '%/77/' then
				print ("77%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/77/' then
				print ("77%N")
			else
				print ("Wrong!%N")
			end

			code := '%/78/'
			inspect code
			when '%/78/' then
				print ("78%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/78/' then
				print ("78%N")
			else
				print ("Wrong!%N")
			end

			code := '%/79/'
			inspect code
			when '%/79/' then
				print ("79%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/79/' then
				print ("79%N")
			else
				print ("Wrong!%N")
			end

			code := '%/80/'
			inspect code
			when '%/80/' then
				print ("80%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/80/' then
				print ("80%N")
			else
				print ("Wrong!%N")
			end

			code := '%/81/'
			inspect code
			when '%/81/' then
				print ("81%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/81/' then
				print ("81%N")
			else
				print ("Wrong!%N")
			end

			code := '%/82/'
			inspect code
			when '%/82/' then
				print ("82%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/82/' then
				print ("82%N")
			else
				print ("Wrong!%N")
			end

			code := '%/83/'
			inspect code
			when '%/83/' then
				print ("83%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/83/' then
				print ("83%N")
			else
				print ("Wrong!%N")
			end

			code := '%/84/'
			inspect code
			when '%/84/' then
				print ("84%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/84/' then
				print ("84%N")
			else
				print ("Wrong!%N")
			end

			code := '%/85/'
			inspect code
			when '%/85/' then
				print ("85%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/85/' then
				print ("85%N")
			else
				print ("Wrong!%N")
			end

			code := '%/86/'
			inspect code
			when '%/86/' then
				print ("86%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/86/' then
				print ("86%N")
			else
				print ("Wrong!%N")
			end

			code := '%/87/'
			inspect code
			when '%/87/' then
				print ("87%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/87/' then
				print ("87%N")
			else
				print ("Wrong!%N")
			end

			code := '%/88/'
			inspect code
			when '%/88/' then
				print ("88%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/88/' then
				print ("88%N")
			else
				print ("Wrong!%N")
			end

			code := '%/89/'
			inspect code
			when '%/89/' then
				print ("89%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/89/' then
				print ("89%N")
			else
				print ("Wrong!%N")
			end

			code := '%/90/'
			inspect code
			when '%/90/' then
				print ("90%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/90/' then
				print ("90%N")
			else
				print ("Wrong!%N")
			end

			code := '%/91/'
			inspect code
			when '%/91/' then
				print ("91%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/91/' then
				print ("91%N")
			else
				print ("Wrong!%N")
			end

			code := '%/92/'
			inspect code
			when '%/92/' then
				print ("92%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/92/' then
				print ("92%N")
			else
				print ("Wrong!%N")
			end

			code := '%/93/'
			inspect code
			when '%/93/' then
				print ("93%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/93/' then
				print ("93%N")
			else
				print ("Wrong!%N")
			end

			code := '%/94/'
			inspect code
			when '%/94/' then
				print ("94%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/94/' then
				print ("94%N")
			else
				print ("Wrong!%N")
			end

			code := '%/95/'
			inspect code
			when '%/95/' then
				print ("95%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/95/' then
				print ("95%N")
			else
				print ("Wrong!%N")
			end

			code := '%/96/'
			inspect code
			when '%/96/' then
				print ("96%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/96/' then
				print ("96%N")
			else
				print ("Wrong!%N")
			end

			code := '%/97/'
			inspect code
			when '%/97/' then
				print ("97%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/97/' then
				print ("97%N")
			else
				print ("Wrong!%N")
			end

			code := '%/98/'
			inspect code
			when '%/98/' then
				print ("98%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/98/' then
				print ("98%N")
			else
				print ("Wrong!%N")
			end

			code := '%/99/'
			inspect code
			when '%/99/' then
				print ("99%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/99/' then
				print ("99%N")
			else
				print ("Wrong!%N")
			end

			code := '%/100/'
			inspect code
			when '%/100/' then
				print ("100%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/100/' then
				print ("100%N")
			else
				print ("Wrong!%N")
			end

			code := '%/101/'
			inspect code
			when '%/101/' then
				print ("101%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/101/' then
				print ("101%N")
			else
				print ("Wrong!%N")
			end

			code := '%/102/'
			inspect code
			when '%/102/' then
				print ("102%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/102/' then
				print ("102%N")
			else
				print ("Wrong!%N")
			end

			code := '%/103/'
			inspect code
			when '%/103/' then
				print ("103%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/103/' then
				print ("103%N")
			else
				print ("Wrong!%N")
			end

			code := '%/104/'
			inspect code
			when '%/104/' then
				print ("104%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/104/' then
				print ("104%N")
			else
				print ("Wrong!%N")
			end

			code := '%/105/'
			inspect code
			when '%/105/' then
				print ("105%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/105/' then
				print ("105%N")
			else
				print ("Wrong!%N")
			end

			code := '%/106/'
			inspect code
			when '%/106/' then
				print ("106%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/106/' then
				print ("106%N")
			else
				print ("Wrong!%N")
			end

			code := '%/107/'
			inspect code
			when '%/107/' then
				print ("107%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/107/' then
				print ("107%N")
			else
				print ("Wrong!%N")
			end

			code := '%/108/'
			inspect code
			when '%/108/' then
				print ("108%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/108/' then
				print ("108%N")
			else
				print ("Wrong!%N")
			end

			code := '%/109/'
			inspect code
			when '%/109/' then
				print ("109%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/109/' then
				print ("109%N")
			else
				print ("Wrong!%N")
			end

			code := '%/110/'
			inspect code
			when '%/110/' then
				print ("110%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/110/' then
				print ("110%N")
			else
				print ("Wrong!%N")
			end

			code := '%/111/'
			inspect code
			when '%/111/' then
				print ("111%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/111/' then
				print ("111%N")
			else
				print ("Wrong!%N")
			end

			code := '%/112/'
			inspect code
			when '%/112/' then
				print ("112%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/112/' then
				print ("112%N")
			else
				print ("Wrong!%N")
			end

			code := '%/113/'
			inspect code
			when '%/113/' then
				print ("113%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/113/' then
				print ("113%N")
			else
				print ("Wrong!%N")
			end

			code := '%/114/'
			inspect code
			when '%/114/' then
				print ("114%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/114/' then
				print ("114%N")
			else
				print ("Wrong!%N")
			end

			code := '%/115/'
			inspect code
			when '%/115/' then
				print ("115%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/115/' then
				print ("115%N")
			else
				print ("Wrong!%N")
			end

			code := '%/116/'
			inspect code
			when '%/116/' then
				print ("116%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/116/' then
				print ("116%N")
			else
				print ("Wrong!%N")
			end

			code := '%/117/'
			inspect code
			when '%/117/' then
				print ("117%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/117/' then
				print ("117%N")
			else
				print ("Wrong!%N")
			end

			code := '%/118/'
			inspect code
			when '%/118/' then
				print ("118%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/118/' then
				print ("118%N")
			else
				print ("Wrong!%N")
			end

			code := '%/119/'
			inspect code
			when '%/119/' then
				print ("119%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/119/' then
				print ("119%N")
			else
				print ("Wrong!%N")
			end

			code := '%/120/'
			inspect code
			when '%/120/' then
				print ("120%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/120/' then
				print ("120%N")
			else
				print ("Wrong!%N")
			end

			code := '%/121/'
			inspect code
			when '%/121/' then
				print ("121%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/121/' then
				print ("121%N")
			else
				print ("Wrong!%N")
			end

			code := '%/122/'
			inspect code
			when '%/122/' then
				print ("122%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/122/' then
				print ("122%N")
			else
				print ("Wrong!%N")
			end

			code := '%/123/'
			inspect code
			when '%/123/' then
				print ("123%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/123/' then
				print ("123%N")
			else
				print ("Wrong!%N")
			end

			code := '%/124/'
			inspect code
			when '%/124/' then
				print ("124%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/124/' then
				print ("124%N")
			else
				print ("Wrong!%N")
			end

			code := '%/125/'
			inspect code
			when '%/125/' then
				print ("125%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/125/' then
				print ("125%N")
			else
				print ("Wrong!%N")
			end

			code := '%/126/'
			inspect code
			when '%/126/' then
				print ("126%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/126/' then
				print ("126%N")
			else
				print ("Wrong!%N")
			end

			code := '%/127/'
			inspect code
			when '%/127/' then
				print ("127%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/127/' then
				print ("127%N")
			else
				print ("Wrong!%N")
			end

			code := '%/128/'
			inspect code
			when '%/128/' then
				print ("128%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/128/' then
				print ("128%N")
			else
				print ("Wrong!%N")
			end

			code := '%/129/'
			inspect code
			when '%/129/' then
				print ("129%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/129/' then
				print ("129%N")
			else
				print ("Wrong!%N")
			end

			code := '%/130/'
			inspect code
			when '%/130/' then
				print ("130%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/130/' then
				print ("130%N")
			else
				print ("Wrong!%N")
			end

			code := '%/131/'
			inspect code
			when '%/131/' then
				print ("131%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/131/' then
				print ("131%N")
			else
				print ("Wrong!%N")
			end

			code := '%/132/'
			inspect code
			when '%/132/' then
				print ("132%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/132/' then
				print ("132%N")
			else
				print ("Wrong!%N")
			end

			code := '%/133/'
			inspect code
			when '%/133/' then
				print ("133%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/133/' then
				print ("133%N")
			else
				print ("Wrong!%N")
			end

			code := '%/134/'
			inspect code
			when '%/134/' then
				print ("134%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/134/' then
				print ("134%N")
			else
				print ("Wrong!%N")
			end

			code := '%/135/'
			inspect code
			when '%/135/' then
				print ("135%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/135/' then
				print ("135%N")
			else
				print ("Wrong!%N")
			end

			code := '%/136/'
			inspect code
			when '%/136/' then
				print ("136%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/136/' then
				print ("136%N")
			else
				print ("Wrong!%N")
			end

			code := '%/137/'
			inspect code
			when '%/137/' then
				print ("137%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/137/' then
				print ("137%N")
			else
				print ("Wrong!%N")
			end

			code := '%/138/'
			inspect code
			when '%/138/' then
				print ("138%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/138/' then
				print ("138%N")
			else
				print ("Wrong!%N")
			end

			code := '%/139/'
			inspect code
			when '%/139/' then
				print ("139%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/139/' then
				print ("139%N")
			else
				print ("Wrong!%N")
			end

			code := '%/140/'
			inspect code
			when '%/140/' then
				print ("140%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/140/' then
				print ("140%N")
			else
				print ("Wrong!%N")
			end

			code := '%/141/'
			inspect code
			when '%/141/' then
				print ("141%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/141/' then
				print ("141%N")
			else
				print ("Wrong!%N")
			end

			code := '%/142/'
			inspect code
			when '%/142/' then
				print ("142%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/142/' then
				print ("142%N")
			else
				print ("Wrong!%N")
			end

			code := '%/143/'
			inspect code
			when '%/143/' then
				print ("143%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/143/' then
				print ("143%N")
			else
				print ("Wrong!%N")
			end

			code := '%/144/'
			inspect code
			when '%/144/' then
				print ("144%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/144/' then
				print ("144%N")
			else
				print ("Wrong!%N")
			end

			code := '%/145/'
			inspect code
			when '%/145/' then
				print ("145%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/145/' then
				print ("145%N")
			else
				print ("Wrong!%N")
			end

			code := '%/146/'
			inspect code
			when '%/146/' then
				print ("146%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/146/' then
				print ("146%N")
			else
				print ("Wrong!%N")
			end

			code := '%/147/'
			inspect code
			when '%/147/' then
				print ("147%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/147/' then
				print ("147%N")
			else
				print ("Wrong!%N")
			end

			code := '%/148/'
			inspect code
			when '%/148/' then
				print ("148%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/148/' then
				print ("148%N")
			else
				print ("Wrong!%N")
			end

			code := '%/149/'
			inspect code
			when '%/149/' then
				print ("149%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/149/' then
				print ("149%N")
			else
				print ("Wrong!%N")
			end

			code := '%/150/'
			inspect code
			when '%/150/' then
				print ("150%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/150/' then
				print ("150%N")
			else
				print ("Wrong!%N")
			end

			code := '%/151/'
			inspect code
			when '%/151/' then
				print ("151%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/151/' then
				print ("151%N")
			else
				print ("Wrong!%N")
			end

			code := '%/152/'
			inspect code
			when '%/152/' then
				print ("152%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/152/' then
				print ("152%N")
			else
				print ("Wrong!%N")
			end

			code := '%/153/'
			inspect code
			when '%/153/' then
				print ("153%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/153/' then
				print ("153%N")
			else
				print ("Wrong!%N")
			end

			code := '%/154/'
			inspect code
			when '%/154/' then
				print ("154%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/154/' then
				print ("154%N")
			else
				print ("Wrong!%N")
			end

			code := '%/155/'
			inspect code
			when '%/155/' then
				print ("155%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/155/' then
				print ("155%N")
			else
				print ("Wrong!%N")
			end

			code := '%/156/'
			inspect code
			when '%/156/' then
				print ("156%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/156/' then
				print ("156%N")
			else
				print ("Wrong!%N")
			end

			code := '%/157/'
			inspect code
			when '%/157/' then
				print ("157%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/157/' then
				print ("157%N")
			else
				print ("Wrong!%N")
			end

			code := '%/158/'
			inspect code
			when '%/158/' then
				print ("158%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/158/' then
				print ("158%N")
			else
				print ("Wrong!%N")
			end

			code := '%/159/'
			inspect code
			when '%/159/' then
				print ("159%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/159/' then
				print ("159%N")
			else
				print ("Wrong!%N")
			end

			code := '%/160/'
			inspect code
			when '%/160/' then
				print ("160%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/160/' then
				print ("160%N")
			else
				print ("Wrong!%N")
			end

			code := '%/161/'
			inspect code
			when '%/161/' then
				print ("161%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/161/' then
				print ("161%N")
			else
				print ("Wrong!%N")
			end

			code := '%/162/'
			inspect code
			when '%/162/' then
				print ("162%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/162/' then
				print ("162%N")
			else
				print ("Wrong!%N")
			end

			code := '%/163/'
			inspect code
			when '%/163/' then
				print ("163%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/163/' then
				print ("163%N")
			else
				print ("Wrong!%N")
			end

			code := '%/164/'
			inspect code
			when '%/164/' then
				print ("164%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/164/' then
				print ("164%N")
			else
				print ("Wrong!%N")
			end

			code := '%/165/'
			inspect code
			when '%/165/' then
				print ("165%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/165/' then
				print ("165%N")
			else
				print ("Wrong!%N")
			end

			code := '%/166/'
			inspect code
			when '%/166/' then
				print ("166%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/166/' then
				print ("166%N")
			else
				print ("Wrong!%N")
			end

			code := '%/167/'
			inspect code
			when '%/167/' then
				print ("167%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/167/' then
				print ("167%N")
			else
				print ("Wrong!%N")
			end

			code := '%/168/'
			inspect code
			when '%/168/' then
				print ("168%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/168/' then
				print ("168%N")
			else
				print ("Wrong!%N")
			end

			code := '%/169/'
			inspect code
			when '%/169/' then
				print ("169%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/169/' then
				print ("169%N")
			else
				print ("Wrong!%N")
			end

			code := '%/170/'
			inspect code
			when '%/170/' then
				print ("170%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/170/' then
				print ("170%N")
			else
				print ("Wrong!%N")
			end

			code := '%/171/'
			inspect code
			when '%/171/' then
				print ("171%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/171/' then
				print ("171%N")
			else
				print ("Wrong!%N")
			end

			code := '%/172/'
			inspect code
			when '%/172/' then
				print ("172%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/172/' then
				print ("172%N")
			else
				print ("Wrong!%N")
			end

			code := '%/173/'
			inspect code
			when '%/173/' then
				print ("173%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/173/' then
				print ("173%N")
			else
				print ("Wrong!%N")
			end

			code := '%/174/'
			inspect code
			when '%/174/' then
				print ("174%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/174/' then
				print ("174%N")
			else
				print ("Wrong!%N")
			end

			code := '%/175/'
			inspect code
			when '%/175/' then
				print ("175%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/175/' then
				print ("175%N")
			else
				print ("Wrong!%N")
			end

			code := '%/176/'
			inspect code
			when '%/176/' then
				print ("176%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/176/' then
				print ("176%N")
			else
				print ("Wrong!%N")
			end

			code := '%/177/'
			inspect code
			when '%/177/' then
				print ("177%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/177/' then
				print ("177%N")
			else
				print ("Wrong!%N")
			end

			code := '%/178/'
			inspect code
			when '%/178/' then
				print ("178%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/178/' then
				print ("178%N")
			else
				print ("Wrong!%N")
			end

			code := '%/179/'
			inspect code
			when '%/179/' then
				print ("179%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/179/' then
				print ("179%N")
			else
				print ("Wrong!%N")
			end

			code := '%/180/'
			inspect code
			when '%/180/' then
				print ("180%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/180/' then
				print ("180%N")
			else
				print ("Wrong!%N")
			end

			code := '%/181/'
			inspect code
			when '%/181/' then
				print ("181%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/181/' then
				print ("181%N")
			else
				print ("Wrong!%N")
			end

			code := '%/182/'
			inspect code
			when '%/182/' then
				print ("182%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/182/' then
				print ("182%N")
			else
				print ("Wrong!%N")
			end

			code := '%/183/'
			inspect code
			when '%/183/' then
				print ("183%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/183/' then
				print ("183%N")
			else
				print ("Wrong!%N")
			end

			code := '%/184/'
			inspect code
			when '%/184/' then
				print ("184%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/184/' then
				print ("184%N")
			else
				print ("Wrong!%N")
			end

			code := '%/185/'
			inspect code
			when '%/185/' then
				print ("185%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/185/' then
				print ("185%N")
			else
				print ("Wrong!%N")
			end

			code := '%/186/'
			inspect code
			when '%/186/' then
				print ("186%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/186/' then
				print ("186%N")
			else
				print ("Wrong!%N")
			end

			code := '%/187/'
			inspect code
			when '%/187/' then
				print ("187%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/187/' then
				print ("187%N")
			else
				print ("Wrong!%N")
			end

			code := '%/188/'
			inspect code
			when '%/188/' then
				print ("188%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/188/' then
				print ("188%N")
			else
				print ("Wrong!%N")
			end

			code := '%/189/'
			inspect code
			when '%/189/' then
				print ("189%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/189/' then
				print ("189%N")
			else
				print ("Wrong!%N")
			end

			code := '%/190/'
			inspect code
			when '%/190/' then
				print ("190%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/190/' then
				print ("190%N")
			else
				print ("Wrong!%N")
			end

			code := '%/191/'
			inspect code
			when '%/191/' then
				print ("191%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/191/' then
				print ("191%N")
			else
				print ("Wrong!%N")
			end

			code := '%/192/'
			inspect code
			when '%/192/' then
				print ("192%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/192/' then
				print ("192%N")
			else
				print ("Wrong!%N")
			end

			code := '%/193/'
			inspect code
			when '%/193/' then
				print ("193%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/193/' then
				print ("193%N")
			else
				print ("Wrong!%N")
			end

			code := '%/194/'
			inspect code
			when '%/194/' then
				print ("194%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/194/' then
				print ("194%N")
			else
				print ("Wrong!%N")
			end

			code := '%/195/'
			inspect code
			when '%/195/' then
				print ("195%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/195/' then
				print ("195%N")
			else
				print ("Wrong!%N")
			end

			code := '%/196/'
			inspect code
			when '%/196/' then
				print ("196%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/196/' then
				print ("196%N")
			else
				print ("Wrong!%N")
			end

			code := '%/197/'
			inspect code
			when '%/197/' then
				print ("197%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/197/' then
				print ("197%N")
			else
				print ("Wrong!%N")
			end

			code := '%/198/'
			inspect code
			when '%/198/' then
				print ("198%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/198/' then
				print ("198%N")
			else
				print ("Wrong!%N")
			end

			code := '%/199/'
			inspect code
			when '%/199/' then
				print ("199%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/199/' then
				print ("199%N")
			else
				print ("Wrong!%N")
			end

			code := '%/200/'
			inspect code
			when '%/200/' then
				print ("200%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/200/' then
				print ("200%N")
			else
				print ("Wrong!%N")
			end

			code := '%/201/'
			inspect code
			when '%/201/' then
				print ("201%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/201/' then
				print ("201%N")
			else
				print ("Wrong!%N")
			end

			code := '%/202/'
			inspect code
			when '%/202/' then
				print ("202%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/202/' then
				print ("202%N")
			else
				print ("Wrong!%N")
			end

			code := '%/203/'
			inspect code
			when '%/203/' then
				print ("203%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/203/' then
				print ("203%N")
			else
				print ("Wrong!%N")
			end

			code := '%/204/'
			inspect code
			when '%/204/' then
				print ("204%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/204/' then
				print ("204%N")
			else
				print ("Wrong!%N")
			end

			code := '%/205/'
			inspect code
			when '%/205/' then
				print ("205%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/205/' then
				print ("205%N")
			else
				print ("Wrong!%N")
			end

			code := '%/206/'
			inspect code
			when '%/206/' then
				print ("206%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/206/' then
				print ("206%N")
			else
				print ("Wrong!%N")
			end

			code := '%/207/'
			inspect code
			when '%/207/' then
				print ("207%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/207/' then
				print ("207%N")
			else
				print ("Wrong!%N")
			end

			code := '%/208/'
			inspect code
			when '%/208/' then
				print ("208%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/208/' then
				print ("208%N")
			else
				print ("Wrong!%N")
			end

			code := '%/209/'
			inspect code
			when '%/209/' then
				print ("209%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/209/' then
				print ("209%N")
			else
				print ("Wrong!%N")
			end

			code := '%/210/'
			inspect code
			when '%/210/' then
				print ("210%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/210/' then
				print ("210%N")
			else
				print ("Wrong!%N")
			end

			code := '%/211/'
			inspect code
			when '%/211/' then
				print ("211%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/211/' then
				print ("211%N")
			else
				print ("Wrong!%N")
			end

			code := '%/212/'
			inspect code
			when '%/212/' then
				print ("212%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/212/' then
				print ("212%N")
			else
				print ("Wrong!%N")
			end

			code := '%/213/'
			inspect code
			when '%/213/' then
				print ("213%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/213/' then
				print ("213%N")
			else
				print ("Wrong!%N")
			end

			code := '%/214/'
			inspect code
			when '%/214/' then
				print ("214%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/214/' then
				print ("214%N")
			else
				print ("Wrong!%N")
			end

			code := '%/215/'
			inspect code
			when '%/215/' then
				print ("215%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/215/' then
				print ("215%N")
			else
				print ("Wrong!%N")
			end

			code := '%/216/'
			inspect code
			when '%/216/' then
				print ("216%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/216/' then
				print ("216%N")
			else
				print ("Wrong!%N")
			end

			code := '%/217/'
			inspect code
			when '%/217/' then
				print ("217%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/217/' then
				print ("217%N")
			else
				print ("Wrong!%N")
			end

			code := '%/218/'
			inspect code
			when '%/218/' then
				print ("218%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/218/' then
				print ("218%N")
			else
				print ("Wrong!%N")
			end

			code := '%/219/'
			inspect code
			when '%/219/' then
				print ("219%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/219/' then
				print ("219%N")
			else
				print ("Wrong!%N")
			end

			code := '%/220/'
			inspect code
			when '%/220/' then
				print ("220%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/220/' then
				print ("220%N")
			else
				print ("Wrong!%N")
			end

			code := '%/221/'
			inspect code
			when '%/221/' then
				print ("221%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/221/' then
				print ("221%N")
			else
				print ("Wrong!%N")
			end

			code := '%/222/'
			inspect code
			when '%/222/' then
				print ("222%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/222/' then
				print ("222%N")
			else
				print ("Wrong!%N")
			end

			code := '%/223/'
			inspect code
			when '%/223/' then
				print ("223%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/223/' then
				print ("223%N")
			else
				print ("Wrong!%N")
			end

			code := '%/224/'
			inspect code
			when '%/224/' then
				print ("224%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/224/' then
				print ("224%N")
			else
				print ("Wrong!%N")
			end

			code := '%/225/'
			inspect code
			when '%/225/' then
				print ("225%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/225/' then
				print ("225%N")
			else
				print ("Wrong!%N")
			end

			code := '%/226/'
			inspect code
			when '%/226/' then
				print ("226%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/226/' then
				print ("226%N")
			else
				print ("Wrong!%N")
			end

			code := '%/227/'
			inspect code
			when '%/227/' then
				print ("227%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/227/' then
				print ("227%N")
			else
				print ("Wrong!%N")
			end

			code := '%/228/'
			inspect code
			when '%/228/' then
				print ("228%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/228/' then
				print ("228%N")
			else
				print ("Wrong!%N")
			end

			code := '%/229/'
			inspect code
			when '%/229/' then
				print ("229%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/229/' then
				print ("229%N")
			else
				print ("Wrong!%N")
			end

			code := '%/230/'
			inspect code
			when '%/230/' then
				print ("230%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/230/' then
				print ("230%N")
			else
				print ("Wrong!%N")
			end

			code := '%/231/'
			inspect code
			when '%/231/' then
				print ("231%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/231/' then
				print ("231%N")
			else
				print ("Wrong!%N")
			end

			code := '%/232/'
			inspect code
			when '%/232/' then
				print ("232%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/232/' then
				print ("232%N")
			else
				print ("Wrong!%N")
			end

			code := '%/233/'
			inspect code
			when '%/233/' then
				print ("233%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/233/' then
				print ("233%N")
			else
				print ("Wrong!%N")
			end

			code := '%/234/'
			inspect code
			when '%/234/' then
				print ("234%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/234/' then
				print ("234%N")
			else
				print ("Wrong!%N")
			end

			code := '%/235/'
			inspect code
			when '%/235/' then
				print ("235%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/235/' then
				print ("235%N")
			else
				print ("Wrong!%N")
			end

			code := '%/236/'
			inspect code
			when '%/236/' then
				print ("236%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/236/' then
				print ("236%N")
			else
				print ("Wrong!%N")
			end

			code := '%/237/'
			inspect code
			when '%/237/' then
				print ("237%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/237/' then
				print ("237%N")
			else
				print ("Wrong!%N")
			end

			code := '%/238/'
			inspect code
			when '%/238/' then
				print ("238%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/238/' then
				print ("238%N")
			else
				print ("Wrong!%N")
			end

			code := '%/239/'
			inspect code
			when '%/239/' then
				print ("239%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/239/' then
				print ("239%N")
			else
				print ("Wrong!%N")
			end

			code := '%/240/'
			inspect code
			when '%/240/' then
				print ("240%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/240/' then
				print ("240%N")
			else
				print ("Wrong!%N")
			end

			code := '%/241/'
			inspect code
			when '%/241/' then
				print ("241%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/241/' then
				print ("241%N")
			else
				print ("Wrong!%N")
			end

			code := '%/242/'
			inspect code
			when '%/242/' then
				print ("242%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/242/' then
				print ("242%N")
			else
				print ("Wrong!%N")
			end

			code := '%/243/'
			inspect code
			when '%/243/' then
				print ("243%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/243/' then
				print ("243%N")
			else
				print ("Wrong!%N")
			end

			code := '%/244/'
			inspect code
			when '%/244/' then
				print ("244%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/244/' then
				print ("244%N")
			else
				print ("Wrong!%N")
			end

			code := '%/245/'
			inspect code
			when '%/245/' then
				print ("245%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/245/' then
				print ("245%N")
			else
				print ("Wrong!%N")
			end

			code := '%/246/'
			inspect code
			when '%/246/' then
				print ("246%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/246/' then
				print ("246%N")
			else
				print ("Wrong!%N")
			end

			code := '%/247/'
			inspect code
			when '%/247/' then
				print ("247%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/247/' then
				print ("247%N")
			else
				print ("Wrong!%N")
			end

			code := '%/248/'
			inspect code
			when '%/248/' then
				print ("248%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/248/' then
				print ("248%N")
			else
				print ("Wrong!%N")
			end

			code := '%/249/'
			inspect code
			when '%/249/' then
				print ("249%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/249/' then
				print ("249%N")
			else
				print ("Wrong!%N")
			end

			code := '%/250/'
			inspect code
			when '%/250/' then
				print ("250%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/250/' then
				print ("250%N")
			else
				print ("Wrong!%N")
			end

			code := '%/251/'
			inspect code
			when '%/251/' then
				print ("251%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/251/' then
				print ("251%N")
			else
				print ("Wrong!%N")
			end

			code := '%/252/'
			inspect code
			when '%/252/' then
				print ("252%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/252/' then
				print ("252%N")
			else
				print ("Wrong!%N")
			end

			code := '%/253/'
			inspect code
			when '%/253/' then
				print ("253%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/253/' then
				print ("253%N")
			else
				print ("Wrong!%N")
			end

			code := '%/254/'
			inspect code
			when '%/254/' then
				print ("254%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/254/' then
				print ("254%N")
			else
				print ("Wrong!%N")
			end

			code := '%/255/'
			inspect code
			when '%/255/' then
				print ("255%N")
			else
				print ("Wrong!%N")
			end

			if code = '%/255/' then
				print ("255%N")
			else
				print ("Wrong!%N")
			end

		end

end
