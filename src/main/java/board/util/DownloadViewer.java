package board.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadViewer extends AbstractView{
	//다운로드할 경로명
	@Value("${upload}")
	private String path;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> 
	model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1. 요청으로 model로 매핑된 파일 객체 생성.
		String fname = (String)model.get("downloadFileName");
		// 2. 파일 객체 생성
		File file = new File(path+fname);
		
		//3. response에 의해 파일객체를 client에 전송
		// 1)파일 전송을 위한 contentType설정
		response.setContentType("application/download;charset=utf-8");
		// 2) 파일의 길이
		response.setContentLength((int)file.length());
		// 3)파일명이 한글인경우 한글 encoding
		fname = URLEncoder.encode(fname,"utf-8").replaceAll("\\+", " ");
		// 4)response의 header정보를 통해서 전송..
		// Content-Disposition : attachment; filename="파일명"
		// Content-Transfer-Encoding : "binary"
		response.setHeader("Content-Disposition", "attachment; filename=\""+fname+"\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		//4.파일을 Stream으로 client에 전송
		//1) FileInputStream
			FileInputStream fis = new FileInputStream(file);
		//2) OutputStream 객체
			OutputStream out = response.getOutputStream();
		//3) FileCopyUtils.copy(fis,out)
			FileCopyUtils.copy(fis, out);
		//4) flush처리
			out.flush();
	}
}
