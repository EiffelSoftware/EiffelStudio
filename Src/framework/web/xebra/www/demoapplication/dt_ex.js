var caldef3 = {
	firstday:1,
	dtype:'MM/dd/yyyy HH:mm:ss',
	width:220,
	windoww:240,
	windowh:200,
	border_width:0,
	border_color:'#efefef',
	dn_css:'clsDayName',
	cd_css:'clsCurrentDay', 
	tw_css:'clsCurrentWeek',  // CSS for current week
	wd_css:'clsWorkDay',
	we_css:'clsWeekEnd',
	wdom_css:'clsWorkDayOtherMonth',
	weom_css:'clsWeekEndOtherMonth',
	wdomcw_css:'clsWorkDayOthMonthCurWeek',
	weomcw_css:'clsWeekEndOthMonthCurWeek',
	wecd_css:'clsWeekEndCurDay',
	wecw_css:'clsWeekEndCurWeek',
	highlight_css:'clsHighLight',
	preview_css:'clsPreview',
	time_css: 'clsTime',
	headerstyle: {
		type:"buttons",
		imgnextm:'img/forward.jpg',
		imgprevm:'img/back.jpg',
		imgnexty:'img/forward.jpg',
		imgprevy:'img/back.jpg',
		css:'clsDayName'
	},
	showtime:true,
	preview:true,				
	monthnames :["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
	daynames : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
	txt:["Previous year", "Previous month", "Next month", "Next year", "Apply"],

	template_path:'',
	img_path:'img/'
};