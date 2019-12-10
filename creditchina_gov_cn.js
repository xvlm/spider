/**
需要查询的企业名称设置成一个数组entList
每秒查一次
*/
const entList = ["上海吴越餐饮经营管理有限公司","上海成钢食品有限公司"];
const accurate_entity_codes = [];
function search(key) {

  var param = {
    keyword: key,
    scenes: selfObj.searchPram.scenes,//
    tableName: selfObj.searchPram.tableName,//
    searchState: selfObj.searchPram.searchState,//
    entityType: selfObj.searchPram.entityType,//
    templateId: selfObj.searchPram.templateid,
    page: 1,
    pageSize: selfObj.searchPram.pageSize,
  }
  jQuery.ajax({
    url: httpUrl.serachUrl,
    type: 'GET',
    data: param,
    dataType: 'json',
    success: function (res) {
      if (res.data.total <= 0) {
        return
      } else {
        console.log(res);
        accurate_entity_codes.push( 
        res.data.list[0]
        );
      }

    },
    error: function (error) {
      $(".search-result-box").hide();
      $(".no-data").show();
    },
  });
}
let i=0;
setTimeout(()=>{
    search(name);
  },i*1000)


// for(const name in entList){
//   i++;
//   setTimeout(()=>{
//     search(name);
//   },i*1000);
  
// }
