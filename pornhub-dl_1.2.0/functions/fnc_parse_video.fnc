function fnc_parse_video() {
    echo -e "\e[1;37m+Regexing Videos Links\e[0m"
    local sitename
    sitename=${1}
#   cat ${global_var_temp}/${global_var_temp_filename} | egrep -aoi '[a-z]{2}\.phncdn\.com\\\/videos\\\/[0-9]*\\\/[0-9]{2}\\\/[0-9]*\\\/[0-9]..P_[0-9]*K_[0-9]*\.mp4\??[a-zA-Z0-9%=&_-]{0,210}' | sed 's/\\\\\//\//g' > ${global_var_temp}/${global_var_videos}
#    cat ${global_var_temp}/${global_var_temp_filename} | egrep -aoi '[a-z]{2}\.phncdn\.com\\\/videos\\\/[0-9]*\\\/[0-9]{2}\\\/[0-9]*\\\/[0-9]*_[0-9]*_[0-9]*P_[0-9]*K_[0-9]*\.mp4\??[a-zA-Z0-9%=&_-]{0,210}' | sed 's/\\\//\//g' > ${global_var_temp}/${global_var_videos}
#    cat ${global_var_temp}/${global_var_temp_filename} | egrep -aoi '[a-z]{2}\.phncdn\.com\\\/videos\\\/[0-9]*\\\/[0-9]{2}\\\/[0-9]*\\\/?[a-zA-Z0-9%=&_-]{0,210}.mp4\??[a-zA-Z0-9%=&_-]{0,210}' | sed 's/\\\//\//g' >${global_var_temp}/${global_var_videos}
	case "${sitename}" in
    	xhamster|XHAMSTER|xHamster)
    cat ${global_var_temp}/${global_var_temp_filename} | sed "s/amp;//g" | egrep -aoi '[0-9]*\-[0-9]*\.[a-z]*\.cdn[0-9]*\.com\\\/[0-9]*\\\/[0-9]*\\\/[0-9]*\\\/[0-9]*p\.[0-9a-z]*\.mp4\?cdn_creation_time=[0-9]*\&cdn_ttl=[0-9]*\&cdn_bw=[0-9]*k\&cdn_bw_fs=[0-9]*k\&cdn_cv_data=([0-9]{1,3}[\.]){3}[0-9]{1,3}-dvp\&cdn_hash=\/?[a-zA-Z0-9%=&_-]{0,210}' | sed 's/\\\//\//g' | sort -u > ${global_var_temp}/${global_var_videos}
	    global_video_name=`cat ${global_var_temp}/${global_var_temp_filename} | egrep -ai "<title>" | cut -d">" -f2 | cut -d"<" -f1 | sed "s/ /_/g"`
	;;
	pornhub|PORNHUB|PornHUB)
	cat ${global_var_temp}/${global_var_temp_filename} | egrep -aoi '[a-z]{2}\.phncdn\.com\\\/videos\\\/[0-9]*\\\/[0-9]{2}\\\/[0-9]*\\\/?[a-zA-Z0-9%=&_-]{0,210}.mp4\??[a-zA-Z0-9%=&_-]{0,210}' | sed 's/\\\//\//g' >${global_var_temp}/${global_var_videos}
	global_video_name=`cat ${global_var_temp}/${global_var_temp_filename} | egrep -ai "<title>" | cut -d">" -f2 | cut -d"<" -f1 | sed -e "s/ - Pornhub.com//g" -e "s/ /_/g"`
	;;
	xvideos|XVIDEOS|xVideos)
	echo "got it"
		cat ${global_var_temp}/${global_var_temp_filename} | grep -aiP 'setVideoUrlLow|setVideoUrlHigh' | cut -d"'" -f2 | sed "s/https:\/\///g"  > ${global_var_temp}/${global_var_videos}
	global_video_name=`cat ${global_var_temp}/${global_var_temp_filename} | egrep -ai "<title>" | cut -d">" -f2 | cut -d"<" -f1 | sed -e "s/ - XVIDEOS.COM//g" -e "s/ /_/g"`
	;;
	*)
	cat ${global_var_temp}/${global_var_temp_filename} | egrep -aoi '[a-z]{2}\.phncdn\.com\\\/videos\\\/[0-9]*\\\/[0-9]{2}\\\/[0-9]*\\\/?[a-zA-Z0-9%=&_-]{0,210}.mp4\??[a-zA-Z0-9%=&_-]{0,210}' | sed 's/\\\//\//g' >${global_var_temp}/${global_var_videos}
	global_video_name=`cat ${global_var_temp}/${global_var_temp_filename} | egrep -ai "<title>" | cut -d">" -f2 | cut -d"<" -f1 | sed -e "s/ - Pornhub.com//g" -e "s/ /_/g"`
	;;
	esac
    if [ -z "${global_video_name}" ]; then
		echo -e "\e[1;37m+Unknown Ttitle (Maybe not english)\e[0m"
		global_video_name=`md5sum ${global_var_temp}/${global_var_videos} | cut -d" " -f1`
	else
		shift
	fi
}
