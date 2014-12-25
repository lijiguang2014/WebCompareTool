/////////////////////////////////////////////////////////////
// pagenation utils
/////////////////////////////////////////////////////////////
function firstPage(pageNoField){
    navigateToPage(1, pageNoField);
}
function prePage(pageNoField, pageNo){
    navigateToPage(pageNo, pageNoField);
}
function nextPage(pageNoField, pageNo){
    navigateToPage(pageNo, pageNoField);
}
function lastPage(pageNoField, totalPages){
    navigateToPage(totalPages, pageNoField);
}
function navigateToPage(pageNum, pageNoField){
	form = document.forms[0];
	form.pageNo.value=pageNum;
    form.submit();
}
function gotoPage(pageNoField){
    form = document.forms[0];
    selectedPageNo = $("input[name='"+pageNoField+"']").value;
    navigateToPage(selectedPageNo, pageNoField);
}
