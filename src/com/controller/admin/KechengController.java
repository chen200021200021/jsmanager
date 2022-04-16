package com.controller.admin;

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
import com.util.MapUtil;
import com.util.WebUtils;

@Controller
@SuppressWarnings("unchecked")
@RequestMapping("admin/kecheng/*")
public class KechengController extends AbstractRestController{	
	@Autowired
	CmmDao dao;
	
	private String tbNm = "kecheng";
	private String tbNmScore = "kecheng_score";
	
	@RequestMapping(value = "getPageList")
	@ResponseBody
	public String getPageList(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		pMap.put("tbNm", this.tbNm);
		if (MapUtil.isContains(pMap, "name")) {
			pMap.put("where", " name like '%" + pMap.get("name") + "%'");
			pMap.put("name", "");
		}
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				map.put("classidNm", dao.getCategoryNm(map.get("classid")));
				map.put("teacheridNm", dao.getUsername(map.get("teacherid")));
			}
		}
		return WebUtils.responseDataToJson(page);
	}
	
	@RequestMapping(value = "getPageList30")
	@ResponseBody
	public String getPageList30(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		pMap.put("tbNm", this.tbNm);
		pMap.put("teacherid", request.getSession().getAttribute("uid"));
		if (MapUtil.isContains(pMap, "name")) {
			pMap.put("where", " name like '%" + pMap.get("name") + "%'");
			pMap.put("name", "");
		}
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				map.put("classidNm", dao.getCategoryNm(map.get("classid")));
				map.put("teacheridNm", dao.getUsername(map.get("teacherid")));
			}
		}
		return WebUtils.responseDataToJson(page);
	}
	
	@RequestMapping(value = "getPageListStudent")
	@ResponseBody
	public String getPageListStudent(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		pMap.put("tbNm", "userinfo20");
		if (MapUtil.isContains(pMap, "name")) {
			pMap.put("where", " name like '%" + pMap.get("name") + "%'");
			pMap.put("name", "");
		}
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				String sql = "select * from kecheng_score where uid="+map.get("id")+" and kechengid="+pMap.get("kechengid");
				Map<String, Object> scoreInfo = dao.getInfo(sql);
				if (MapUtil.isContains(scoreInfo, "id")) {
					map.put("score", scoreInfo.get("score"));
					map.put("xuefen", scoreInfo.get("xuefen"));
				} else {
					map.put("score", "-");
					map.put("xuefen", "-");
				}
			}
		}
		return WebUtils.responseDataToJson(page);
	}
	
	@RequestMapping(value = "getScoreInfo")
	@ResponseBody
	public String getScoreInfo(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		String sql = "select * from kecheng_score where uid="+pMap.get("uid")+" and kechengid="+pMap.get("kechengid");
		Map<String, Object> info = dao.getInfo(sql);
		String rtStr = JSON.toJSONString(info);
		return rtStr;
	}
	
	@RequestMapping(value = "getPageListKecheng20")
	@ResponseBody
	public String getPageListKecheng20(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		pMap.put("tbNm", this.tbNm);
		String uid = request.getSession().getAttribute("uid").toString();
		String sql = "select * from userinfo20 where id="+uid;
		Map<String, Object> userInfo = dao.getInfo(sql);
		if (!MapUtil.isContains(userInfo, "classid")) {
			return WebUtils.responseDataToJson(new Page());
		}
		pMap.put("classid", userInfo.get("classid"));
		if (MapUtil.isContains(pMap, "name")) {
			pMap.put("where", " name like '%" + pMap.get("name") + "%'");
			pMap.put("name", "");
		}
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				map.put("classidNm", dao.getCategoryNm(map.get("classid")));
				map.put("teacheridNm", dao.getUsername(map.get("teacherid")));
			}
		}
		return WebUtils.responseDataToJson(page);
	}
	
	@RequestMapping(value = "getPageListXuefen20")
	@ResponseBody
	public String getPageListXuefen20(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		String uid = request.getSession().getAttribute("uid").toString();
		pMap.put("tbNm", "kecheng_score");
		pMap.put("uid", uid);
		Page page = dao.getPage(pMap);
		List<Map<String, Object>> dataList = page.getDataList();
		if (dataList!=null) {
			for(Map<String, Object> map : dataList) {
				map.put("kechengidNm", dao.getFieldValById(String.valueOf(map.get("kechengid")), "name", "kecheng"));
			}
		}
		return WebUtils.responseDataToJson(page);
	}
	
	@RequestMapping(value = "updateScore")
	@ResponseBody
	public String updateScore(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		if (!MapUtil.isContains(pMap, "id")) {
			dao.add(pMap, this.tbNmScore);
		} else {
			dao.update(pMap, this.tbNmScore);
		}
		return WebUtils.successResp(null,"操作成功");
	}
	
	@RequestMapping(value = "getInfo")
	@ResponseBody
	public String getInfo(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		Map<String, Object> info = dao.getInfoById(String.valueOf(pMap.get("id")), this.tbNm);
		String rtStr = JSON.toJSONString(info);
		return rtStr;
	}
	
	@RequestMapping(value = "update")
	@ResponseBody
	public String update(@RequestParam Map<String, Object> pMap, HttpServletRequest request){
		String sql = "select * from user where utype='30' and id="+pMap.get("teacherid");
		Map<String, Object> user = dao.getInfo(sql);
		if (!MapUtil.isContains(user, "id")) {
			return WebUtils.errorResp("教师编号不存在！");
		}
		sql = "select * from userinfo30 where id="+pMap.get("teacherid");
		Map<String, Object> userinfo = this.dao.getInfo(sql);
		if (!pMap.get("teacherid").equals(userinfo.get("teacherid"))) {
			//return WebUtils.errorResp("课程所属班级与教师所属班级不一致！");
		}
		if (!MapUtil.isContains(pMap, "id")) {
			dao.add(pMap, this.tbNm);
		} else {
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
