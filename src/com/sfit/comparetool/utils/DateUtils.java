package com.sfit.comparetool.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 * 日期处理工具类，提供常用的日期操作
 * @author LiJianlin
 *
 */
public class DateUtils {
	public static final SimpleDateFormat lformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat gmtFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
	public static final long second = 1000;
	public static final long minute = 60 * second;
	public static final long hour = 60 * minute;
	
	{
		gmtFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
	}
	/**
	 * 得到当前时间的字符串形式，格式默认为yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static String currentTime() {
		
		return currentTime(null, null);
	}
	
	/**
	 * 根据给定的java.util.Date得到字符串形式，格式默认为yyyy-MM-dd HH:mm:ss
	 * @param date
	 * @return
	 */
	public static String currentTime(Date date) {
		
		return currentTime(date, null);
	}
	
	/**
	 * 得到当前根据给定的格式进行格式化后的时间
	 * @param Date date
	 * @param String pattern
	 * @return 格式化后的时间字符串
	 */
	public static String currentTime(Date date , String pattern){
		if(date == null)
			date = new Date();
		
		if(!isNullOrEmptyString(pattern))
			return new SimpleDateFormat(pattern).format(date);
		
		return lformat.format(date);
	}
	
	public static boolean isNullOrEmptyString(Object destObj) {
		if(destObj == null)
			return true;
		
		if(destObj instanceof String) {
			if(((String)destObj).trim().equals(""))
				return true;
		}
		return false;
	}
	
	/**
	 * 格式化给定的date,默认格式为：yyyy-MM-dd HH:mm:ss
	 * @param date java.util.Date
	 * @return 
	 */
	public static String format(Date date) {
		return format(date,null);
	}
	
	/**
	 * 根据给定的模式格式化给定的date
	 * @param date java.util.Date
	 * @param pattern 日期模式比如"yyyy-MM-dd HH:mm:ss"
	 * @return 格式化后的日期字符串
	 */
	public static String format(Date date , String pattern){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		if(!isNullOrEmptyString(pattern))
			return new SimpleDateFormat(pattern).format(date);
		
		return lformat.format(date);
	}
	
	/**
	 * 根据给定的模式格式化给定的date字符串
	 * @param sourceDate String类型的日期
	 * @param pattern 日期格式默认为:"yyyy-MM-dd HH:mm:ss"
	 * @return 解析成的java.util.Date
	 * @throws ParseException
	 */
	public static Date parse(String sourceDate , String pattern) throws ParseException{
		if(isNullOrEmptyString(sourceDate))
			throw new NullPointerException("date string needed to calculate is null or empty string");	
		
		if(!isNullOrEmptyString(pattern)) {
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			return sdf.parse(sourceDate);
		}
			
		return lformat.parse(sourceDate);
	}
	
	/**
	 * 重载的根据给定的源时间，目标时间，计算出相差的小时(处理为整点比如：2011-11-11 11:00:00)
	 * @param source String 日期格式默认为:"yyyy-MM-dd HH:mm:ss"
	 * @param dest  Date
	 * @return 返回一个List<String>，里边放的是具体的小时
	 * @throws ParseException 
	 */
	public static List<Date> getHours(String source,Date dest) throws ParseException{
		if(isNullOrEmptyString(source) || dest == null)
			throw new NullPointerException("date string needed to calculate is null or empty string");	
		
		Date src = lformat.parse(source);
		return getHours(src,dest);
	}
	
	/**
	 * 重载的根据给定的源时间，目标时间，计算出相差的小时(处理为整点比如：2011-11-11 11:00:00)
	 * @param source String 日期格式默认为:"yyyy-MM-dd HH:mm:ss"
	 * @param dest   String 日期格式默认为:"yyyy-MM-dd HH:mm:ss"
	 * @return
	 * @throws ParseException 
	 */
	public static List<Date> getHours(String source,String dest) throws ParseException{
		if(isNullOrEmptyString(source) || isNullOrEmptyString(dest))
			throw new NullPointerException("date string needed to calculate is null or empty string");	
		
		Date src = lformat.parse(source);
		Date des = lformat.parse(dest);
		return getHours(src,des);
	}
	
	/**
	 * 重载的根据给定的源时间，目标时间，计算出相差的小时(处理为整点比如：2011-11-11 11:00:00)
	 * @param source Date
	 * @param dest   String 日期格式默认为:"yyyy-MM-dd HH:mm:ss"
	 * @return
	 * @throws ParseException 
	 */
	public static List<Date> getHours(Date source,String dest) throws ParseException{
		if(source == null || isNullOrEmptyString(dest))
			throw new NullPointerException("date needed to calculate is null");
		
		Date des = lformat.parse(dest);
		return getHours(source,des);
	}
	
	/**
	 * 根据给定的源时间，目标时间，计算出相差的小时(处理为整点比如：2011-11-11 11:00:00)
	 * @param source String
	 * @param dest  Date
	 * @return 返回一个List<Date>，里边放的是具体的小时
	 * @throws ParseException 
	 */
	public static List<Date> getHours(Date source,Date dest) throws ParseException{
		
		if(source == null || dest == null)
			throw new NullPointerException("date needed to calculate is null");
		
		long s=source.getTime();
		long d = dest.getTime();
		
		Calendar cs = Calendar.getInstance();
		Calendar cd = Calendar.getInstance();
		
		cs.setTimeInMillis(s);
		cs.set(cs.get(Calendar.YEAR), cs.get(Calendar.MONTH), cs.get(Calendar.DAY_OF_MONTH), cs.get(Calendar.HOUR_OF_DAY), 0, 0);
		
		cd.setTimeInMillis(d);
		cd.set(cd.get(Calendar.YEAR), cd.get(Calendar.MONTH), cd.get(Calendar.DAY_OF_MONTH), cd.get(Calendar.HOUR_OF_DAY), 0, 0);
		
		int i=-1; 
		List<Date> list = new ArrayList<Date>();
		String s1;
		while(i<0){
			s1 = lformat.format(cs.getTime());
			list.add(cs.getTime());
			s1=increaseByHour2DateString(s1, 1);
			i=cs.compareTo(cd);
			cs.setTimeInMillis(lformat.parse(s1).getTime());
		}
		return list;
	}
	
	/**
	 * 根据给定的字符串日期,增加给定的int类型的hours小时
	 * @param hours 要增加的小时数
	 * @param  一个String类型的参数
	 * @return 返回增加一小时以后的格式化的字符串("yyyy-MM-dd HH:mm:ss")
	 * @throws ParseException 
	 */
	public static String increaseByHour2DateString(String source, int hours) throws ParseException{
		if(isNullOrEmptyString(source))
			throw new NullPointerException("date string source needed to convert is null or empty string");	
		
		Date d = lformat.parse(source);
		d = new Date(increaseMinutes(d.getTime(), hours * 60));
		return lformat.format(d);
	} 
	
	/**
	 * 根据给定的日期，增加给定的int类型的hours小时
	 * @param hours 要增加的小时数
	 * @param  一个Date
	 * @return 返回增加一小时以后的格式化的字符串("yyyy-MM-dd HH:mm:ss")
	 */
	public static String increaseByHour2DateString(Date date, int hours){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		Date d = new Date(increaseMinutes(date.getTime(), hours * 60));
		return lformat.format(d);
	}
	
	/**
	 * 根据给定的日期，增加给定的int类型的hours小时
	 * @param hours 要增加的小时数
	 * @param  一个Date
	 * @return 返回增加一小时以后的Date
	 * @throws ParseException 
	 */
	public static Date increaseByHour2Date(Date date, int hours){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		return new Date(increaseMinutes(date.getTime(), hours * 60));
	}
	
	/**
	 * 根据给定的日期，增加给定的int类型的months月
	 * @param date 一个Date
	 * @param months 要增加的月数
	 * @return 返回增加一个月以后的Date
	 */
	public static Date increaseByMonth2Date(Date date, int months){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, months);
		return c.getTime();
	}
	
	/**
	 * 根据给定的日期，增加给定的int值天
	 * @param date 源时间
	 * @param days 要增加的天数
	 * @return 返回增加int天以后的Date
	 * @throws ParseException 
	 */
	public static Date increaseByDay2Date(Date sourDate, int days) throws ParseException {
		
		return increaseByHour2Date(sourDate, days*24);
	}
	
	/**
	 * 根据给定的日期，计算之前int天的日期
	 * @param date 指定日期
	 * @param days 之前天数
	 * @return 计算好的日期
	 */
	public static Date beforeByDays2DateString(Date date, int days){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH, -days);
		Date d = c.getTime();
		return d;
	}
	
	/**
	 * 把一个字符串转化为一个java.util.Date()，默认格式为"yyyy-MM-dd HH:mm:ss"
	 * @param String source 
	 * @return java.util.Date()
	 * @throws ParseException 
	 */
	public static Date String2Date(String source) throws ParseException{
		return String2Date(source,null);
	}
	
	/**
	 * 把一个字符串source，根据给定的格式pattern转化为一个java.util.Date(),如果pattern为空则按默认格式"yyyy-MM-dd HH:mm:ss"
	 * 给定的格式必须要与源字符串格式相等
	 * @param String source
	 * @param String pattern
	 * @return
	 * @throws ParseException 
	 */
	public static Date String2Date(String source,String pattern) throws ParseException{
		if(isNullOrEmptyString(source))
			throw new NullPointerException("date string source needed to convert is null or empty string");	
		
		if(!isNullOrEmptyString(pattern))
				return new SimpleDateFormat(pattern).parse(source);
		
		return lformat.parse(source);
	}
	
	/**
	 * 把一个java.util.Date()转化为一个字符串，默认格式为（"yyyy-MM-dd HH:mm:ss"）
	 * @param Date date
	 * @return String
	 */
	public static String Date2String(Date date){
		return Date2String(date,null);
	}
	
	/**
	 *  把一个java.util.Date()根据给定的格式pattern转化为一个字符串
	 * @param  Date d
	 * @param  String pattern
	 * @return String
	 */
	public static String Date2String(Date date,String pattern){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		if(!isNullOrEmptyString(pattern))
			return new SimpleDateFormat(pattern).format(date);
		
		return lformat.format(date);
	}
	
	/**
	 * 根据给定的日期，增加minutes分钟
	 * @param  一个Date, 分钟数minutes
	 * @return 返回增加minutes分钟以后的Date
	 */
	public static Date increaseByMinute2Date(Date date, int minutes){
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		return new Date(increaseMinutes(date.getTime(),minutes));
	}
	
	/**
	 * 根据给定的时间，得到一天（24小时）后的时间
	 * @param current
	 * @return
	 */
	public static Long getAfterDay(long current) {
		return increaseMinutes(current, 24 * hour);
	}
	
	/**
	 * 把java.util.Date转换为java.util.GregorianCalendar，默认格式为2012-08-20T10:53:30Z
	 * @param date
	 * @return
	 */
	public static String date2GregorianTime(Date date) {
		
		return date2GregorianTime(date, null);
	}
	
	/**
	 * 把java.util.Date转换为java.util.GregorianCalendar，格式为给定的format格式
	 * @param date  待转换的java.util.Date
	 * @param format 指定的时间格式
	 * @return
	 */
	public static String date2GregorianTime(Date date, String format) {
		if(date == null)
			throw new NullPointerException("date needed to convert is null");
		
		return date2GregorianTime(date.getTime(), format);
	}
	
	/**
	 * 根据给定的毫秒数、格式转换成对应的格林威治时间
	 * @param date 待转换的java.util.Date时间毫秒数
	 * @param format 格林威治时间格式
	 * @return
	 */
	public static String date2GregorianTime(long date , String format) {
		String time = null;
		Date d = new Date(date);
		
		if(isNullOrEmptyString(format)) {
			time = gmtFormat.format(d);
		}else {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
			time = sdf.format(d);
		}

		return time;
	}
	
	/**
	 * 根据给定的毫秒数转换成对应的格林威治时间，默认格式为：yyyy-MM-dd'T'HH:mm:ss'Z'
	 * @param date 待转换的java.util.Date时间毫秒数
	 * @return
	 */
	public static String date2GregorianTime(long date) {

		return date2GregorianTime(date,null);
	}
	
	/**
	 * 根据给定的Date格式的start,end计算出相差的天数,eg:2012-08-24 ……2012-08-30，相差7天
	 * @param strat 开始日期
	 * @param end   结束日期
	 * @return 返回包含开始日期和结束日期的相差天数
	 */
	public static int getDaysInterval(Date start, Date end) {
		int interval = 1;
		
		Calendar cs = Calendar.getInstance();
		cs.setTime(start);
		cs.set(cs.get(Calendar.YEAR), cs.get(Calendar.MONTH), cs.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		int day = cs.get(Calendar.DAY_OF_YEAR);
		Calendar cd = Calendar.getInstance();
		cd.setTime(end);
		cd.set(cd.get(Calendar.YEAR), cd.get(Calendar.MONTH), cd.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		
		int i = -1;
		while(i<0) {
			interval++;
			cs.set(Calendar.DAY_OF_YEAR, day++);
			i = cs.compareTo(cd);
		}
		
		return interval;
	}
	
	/**
	 * 根据给定的时间加上给定的分钟数
	 * @param sourTime
	 * @param minutes
	 * @return
	 */
	public static long increaseMinutes(long sourTime, long minutes) {

		return sourTime + minutes * minute;
	}
}
