package com.sfit.comparetool.web.utils.taglib;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class PagenationTag extends TagSupport {

	/**
	 * four property name of pagenationTag
	 */
	private String pageNoProperty = "";
	private String totalPagesProperty = "";
	private String recordCountProperty = "";
	private String callBack = "";
	private String type = "";
	
	/**
	 * css
	 */
	private String style;
	
    /**
	 * the values selected of the four properties
	 */
	private int pageNoValue;
	private int totalPagesValue;
	private long recordCountValue;
	
	 /**
	 * retrive the bean properties of the list value submited by UI
	 */
	private void retriveBeanPropertiesValue() {
		Integer pageNoValueStr = (Integer) pageContext.findAttribute(pageNoProperty);
		if (null == pageNoValueStr) {
			pageNoValue = 1;
		} else {
			pageNoValue = Integer.valueOf(pageNoValueStr);
		}
		
		Integer totalPagesValueStr = (Integer) pageContext.findAttribute(totalPagesProperty);
		if (null == totalPagesValueStr) {
			totalPagesValue = 1;
		} else {
			totalPagesValue = Integer.valueOf(totalPagesValueStr);
		}
		
		Long recordCountValueStr = (Long) pageContext.findAttribute(recordCountProperty);
		if (null == recordCountValueStr) {
			recordCountValue = 0;
		} else {
			recordCountValue = Long.valueOf(recordCountValueStr);
		}
	}
	
	
	@Override
	public int doStartTag() throws JspException {
		// Skip the body of this tag
		return SKIP_BODY;
	}
	
	@Override
	public int doEndTag() throws JspException {
		
		StringBuffer listAll = new StringBuffer();
		ResourceBundle bundle = ResourceBundle.getBundle("application", Locale.CHINA);
		
		retriveBeanPropertiesValue();
		
		boolean prepageTag    = true;
        boolean nextpageTag   = true;
        boolean firstpageTag  = true;
        boolean lastpageTag   = true;
        
        if (pageNoValue >= totalPagesValue) {
        	nextpageTag = false;
        	lastpageTag = false;
        }
        
        if (1 == pageNoValue) {
        	firstpageTag = false;
        	prepageTag = false;
        }
		
		
		//build UI
		listAll.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td>\n");
		if(style != null)
		    listAll.append("<div align=\"right\" class=" + style + ">\n");
        else
            listAll.append("<div align=\"right\">\n");	

		if ("full".equals(type)) {
			// add recordCount property
			listAll.append(bundle.getString("label.public.total"));
			listAll.append(recordCountValue);
			listAll.append(bundle.getString("label.public.recordCount")+" ");
			// add pageCount property
			listAll.append(bundle.getString("label.public.total"));
			listAll.append(totalPagesValue);
			listAll.append(bundle.getString("label.public.page")+"  ");
		}
        
		if ("full".equals(type)) {
			//first page
			if (firstpageTag) {
				listAll.append("<button onclick=\"");
				
				//if pass the callback attribute, generate the callback method.
				if ( !(callBack==null || callBack.trim().equals("")) ) {
					listAll.append(callBack+"();");
				}
				listAll.append("firstPage('" + pageNoProperty + "');return false;\">" + bundle.getString("link.public.firstPage")+"</button>\n");
			} else {
				listAll.append(" " + bundle.getString("link.public.firstPage") + " ");
			}
		}
        
        int pageNo = 1; 
        pageNo = pageNoValue;
        if (pageNo - 1 >= 1) {
        	pageNo -= 1;
        } 
        
        if (prepageTag) {
            listAll.append("<button onclick=\"");
            	
            //if pass the callback attribute, generate the callback method.
            if ( !(callBack==null || callBack.trim().equals("")) ) {
                listAll.append(callBack+"();");
            }
            listAll.append("prePage('"   + pageNoProperty + "'," + pageNo + ");return false;\">" + bundle.getString("link.public.previousPage")+"</button>\n");
        } else {
             listAll.append(" " + bundle.getString("link.public.previousPage") + " ");
        }
        
        pageNo = 1;
        pageNo = pageNoValue;
        if (pageNo + 1 <= totalPagesValue) {
        	pageNo += 1;
        } else {
        	pageNo = totalPagesValue;
        }
        
        if (nextpageTag) {
            listAll.append("<button onclick=\"");

             //if pass the callback attribute, generate the callback method.
            if ( !(callBack==null || callBack.trim().equals("")) ) {
                listAll.append(callBack+"();");
            }
            listAll.append("nextPage('"  + pageNoProperty + "'," + pageNo + ");return false;\">" + bundle.getString("link.public.nextPage")+"</button>\n");
        } else {
            listAll.append(" " + bundle.getString("link.public.nextPage") + " ");
        }
        
        if ("full".equals(type)) {
        	//last page
        	if (lastpageTag) {
        		listAll.append("<button onclick=\"");
        		
        		//if pass the callback attribute, generate the callback method.
        		if ( !(callBack==null || callBack.trim().equals("")) ) {
        			listAll.append(callBack+"();");
        		}
        		listAll.append("lastPage('"  + pageNoProperty + "'," + totalPagesValue + ");return false;\">" + bundle.getString("link.public.lastPage")+"</button>\n");
        	} else {
        		listAll.append(" " + bundle.getString("link.public.lastPage") + " ");
        	}
        	
        	//      goto page
        	int nTextLength=String.valueOf(totalPagesValue).trim().length();
        	listAll.append(bundle.getString("label.public.jumpto")+bundle.getString("label.public.the")+" \n <input type='text' name=\"selectedPage\" onchange=\"validateSelectPage();\"");
        	
        	//if pass the callback attribute, generate the callback method.
        	
        	listAll.append(" size='"+nTextLength+"' maxlength='"+nTextLength+"' value='"+pageNoValue+"'>");
        	
        	listAll.append("</input>"+bundle.getString("label.public.page"));
        	listAll.append("<input type='button' value='go' onclick=\"");
        	if ( !(callBack==null || callBack.trim().equals("")) ) {
        		listAll.append(callBack+"();");
        	}
        	listAll.append("gotoPage('" + pageNoProperty + "');\">");
        }
	     
	     listAll.append("</div>\n");
		 listAll.append("</td></tr></table>\n");
 		
		 listAll.append("<input type=\"hidden\" id=\"" + pageNoProperty + "\" name=\"" + pageNoProperty + "\" value=\"" + pageNoValue + "\"/>\n");
			
			
			listAll.append("<script language=\"javascript\">\n");
			listAll.append(" function validateSearchPageText(form) \n");
			listAll.append(" {\n");
			listAll.append(" return validateRequired(form) && validateInteger(form); \n");
			listAll.append(" }\n");
			listAll.append(" function required () {\n"); 
			listAll.append("     this.aa = new Array(\"selectedPage\", \"跳转页 是必填字段\", new Function (\"varName\", \" return this[varName];\"));\n");
			listAll.append("    } \n");

			listAll.append("    function IntegerValidations () {\n"); 
			listAll.append("     this.aa = new Array(\"selectedPage\", \"跳转页 必须是整数\", new Function (\"varName\", \" return this[varName];\"));\n");
			listAll.append("    } \n");
			
			listAll.append(" function validateSelectPage()\n");
			listAll.append(" {\n");
			listAll.append(" var form = document.forms[0];\n");
			listAll.append(" if (!validateSearchPageText(form))\n");
			listAll.append(" {\n");
			listAll.append(" form.selectedPage.value=\"1\"\n");
			listAll.append(" form.selectedPage.focus();\n");
			listAll.append(" }\n");
			listAll.append(" }\n");
			listAll.append(" </script>\n");
 		
		JspWriter writer = pageContext.getOut();
		try
		{
			writer.write(listAll.toString());
		} catch (IOException e)
		{
            e.printStackTrace();
			throw new JspTagException(e.toString());
		}		
		return TagSupport.EVAL_PAGE;
	}

	public String getPageNoProperty() {
		return pageNoProperty;
	}


	public void setPageNoProperty(String pageNoProperty) {
		this.pageNoProperty = pageNoProperty;
	}


	public String getTotalPagesProperty() {
		return totalPagesProperty;
	}


	public void setTotalPagesProperty(String totalPagesProperty) {
		this.totalPagesProperty = totalPagesProperty;
	}


	public String getRecordCountProperty() {
		return recordCountProperty;
	}


	public void setRecordCountProperty(String recordCountProperty) {
		this.recordCountProperty = recordCountProperty;
	}


	public String getCallBack() {
		return callBack;
	}


	public void setCallBack(String callBack) {
		this.callBack = callBack;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}
	
}
