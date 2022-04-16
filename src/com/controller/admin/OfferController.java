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
@RequestMapping("admin/offer/*")
public class OfferController extends AbstractRestController{	
	@Autowired
	CmmDao dao;
	
	private String tbNm = "offer";
	
	@RequestMapping(value = "getPageListMy")
	@ResponseBody
	public String getPageListMy(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		pMap.put("tbNm", this.tbNm);
		pMap.put("uid", request.getSession().getAttribute("uid"));
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
			}
		}
		return WebUtils.responseLayuiJson(page);
	}
	
	@RequestMapping(value = "getPageList")
	@ResponseBody
	public String getPageList(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		pMap.put("tbNm", this.tbNm);
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				map.put("uidNm", dao.getUsername(map.get("uid")));
			}
		}
		return WebUtils.responseLayuiJson(page);
	}
	
	@RequestMapping(value = "getInfo")
	@ResponseBody
	public String getInfo(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		Map<String, Object> info = dao.getInfoById(String.valueOf(pMap.get("id")), this.tbNm);
		String rtStr = JSON.toJSONString(info);
		return rtStr;
	}
	
	@RequestMapping(value = "update.do")
	@ResponseBody
	public String update(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		Map<String, Object> tObjMap = new HashMap<String, Object>();
		tObjMap.put("uid", pMap.get("uid"));
		tObjMap.put("ym", pMap.get("ym"));
		List<Map<String, Object>> haveList = dao.getList(tObjMap, tbNm);
		Map<String, Object> userInfo = dao.getInfo("select * from user where utype='30' and id="+pMap.get("uid"));
		if (!MapUtil.isContains(userInfo, "id")) {
			return WebUtils.errorResp("教师信息不存在");
		}
		
		if (!MapUtil.isContains(pMap, "id")) {
			if (haveList.size()>0) {
				return WebUtils.errorResp("不能重复添加信息");
			}
			dao.add(pMap, this.tbNm);
		} else {
			if (haveList.size()>0 && !pMap.get("uid").toString().equals(haveList.get(0).get("uid").toString())) {
				return WebUtils.errorResp("不能重复添加信息");
			}
			dao.update(pMap, this.tbNm);
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
		dao.del(String.valueOf(pMap.get("id")), tbNm);
		return WebUtils.successResp(null,"操作成功");
	}
	
	

}
