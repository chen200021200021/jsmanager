package com.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.core.AbstractRestController;
import com.core.Page;
import com.dao.CmmDao;
import com.util.DateUtil;
import com.util.MapUtil;
import com.util.WebUtils;

@Controller
@SuppressWarnings("unchecked")
@RequestMapping("admin/userinfo30/*")
public class UserInfo30Controller extends AbstractRestController{	
	@Autowired
	CmmDao dao;
	
	private String tbNm = "userinfo30";
	private String tbNmUser = "user";
	
	
	
	@RequestMapping(value = "getPageList")
	@ResponseBody
	public String getPageList(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		String sql = "Select a.id,b.name name1,b.* From "+tbNmUser+" a left join "+tbNm+" b on a.id=b.id where utype='30' ";
		if (MapUtil.isContains(pMap, "name")) {
			sql += " and b.name like '%" + pMap.get("name") + "%'";
		}
		if (MapUtil.isContains(pMap, "id")) {
			sql += " and a.id="+pMap.get("id");
		}
		if (MapUtil.isContains(pMap, "xueyuanid")) {
			sql += " and b.xueyuanid="+pMap.get("xueyuanid");
		}
		if (MapUtil.isContains(pMap, "zhuanyeid")) {
			sql += " and b.zhuanyeid="+pMap.get("zhuanyeid");
		}
		if (MapUtil.isContains(pMap, "classid")) {
			sql += " and b.classid="+pMap.get("classid");
		}
		if (MapUtil.isContains(pMap, "no")) {
			sql += " and b.no='"+pMap.get("no")+"'";
		}
		pMap.put("sql", sql);
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				map.put("xueyuanidNm", dao.getCategoryNm(map.get("xueyuanid")));
				map.put("zhuanyeidNm", dao.getCategoryNm(map.get("zhuanyeid")));
				map.put("classidNm", dao.getCategoryNm(map.get("classid")));
			}
		}
		return WebUtils.responseDataToJson(page);
	}
	
	@RequestMapping(value = "getInfo")
	@ResponseBody
	public String getInfo(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		if (!MapUtil.isContains(pMap, "id")) {
			pMap.put("id", request.getSession().getAttribute("uid"));
		}
		Map<String, Object> info = dao.getInfoById(String.valueOf(pMap.get("id")), this.tbNm);
		info.put("itime", DateUtil.getDateStrByTimestamp(info.get("itime")));
		info.put("xueyuanidNm", dao.getCategoryNm(info.get("xueyuanid")));
		String rtStr = JSON.toJSONString(info);
		return rtStr;
	}
	
	@RequestMapping(value = "update")
	@ResponseBody
	public String update(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		if (!MapUtil.isContains(pMap, "id")) {
			pMap.put("id", request.getSession().getAttribute("uid"));
		}
		
		Map<String, Object> info = dao.getInfoById(String.valueOf(pMap.get("id")), this.tbNm);
		if (!MapUtil.isContains(info, "id")) {
			dao.add(pMap, this.tbNm);
		} else {
			dao.update(pMap, this.tbNm);
			Map<String, Object> tObjMap = new HashMap<String, Object>();
			tObjMap.put("id", pMap.get("id"));
			tObjMap.put("name", pMap.get("name"));
			dao.update(tObjMap, "user");
		}
		return WebUtils.successResp(null,"操作成功");
	}

	/**
	 * 删除
	 * @param pMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "del")
	@ResponseBody
	public String del(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		dao.del(String.valueOf(pMap.get("id")), tbNmUser);
		dao.del(String.valueOf(pMap.get("id")), tbNm);
		return WebUtils.successResp(null,"操作成功");
	}
	
}
