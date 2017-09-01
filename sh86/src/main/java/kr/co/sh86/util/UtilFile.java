package kr.co.sh86.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.sh86.user.domain.UploadFileDTO;

public class UtilFile {
	//다중파일업로드
	public List<UploadFileDTO> multiUploadFile(MultipartHttpServletRequest request){
		List<UploadFileDTO> uploadFileList = new ArrayList<UploadFileDTO>();
		//호스팅
		/*String rootPath = "/home/hosting_users/sh86/tomcat/webapps/files/";*/
		
		//로컬
		String rootPath = "C:\\Users\\FreeUser\\Documents\\workspace-sts-3.9.0.RELEASE\\sh86\\src\\main\\webapp\\resources\\files\\";
		List<MultipartFile> multipartFile = request.getFiles("uploadFile");
        if (multipartFile.size() == 1 && multipartFile.get(0).getOriginalFilename().equals("")) {
        } else {
            for (int i = 0; i < multipartFile.size(); i++) {
            	UploadFileDTO uploadFile = uploadFile(multipartFile.get(i), rootPath);
                uploadFileList.add(uploadFile);
            }
        }
		return uploadFileList;	
	}
	//단일파일 업로드
	public UploadFileDTO singleUploadFile(MultipartHttpServletRequest request){
		//호스팅
		/*String rootPath = "/home/hosting_users/sh86/tomcat/webapps/files/";*/
		
		//로컬
		String rootPath = "C:\\Users\\FreeUser\\Documents\\workspace-sts-3.9.0.RELEASE\\sh86\\src\\main\\webapp\\resources\\files\\";
		
		return uploadFile(request.getFile("uploadFile"), rootPath);
	}
	
	//파일업로드 메소드 (DTO반환)
	public UploadFileDTO uploadFile(MultipartFile multipartFile, String rootPath){
		UploadFileDTO uploadFile = new UploadFileDTO();
		try {
			String originalName = multipartFile.getOriginalFilename(); //원래 파일명
	    	int index = originalName.lastIndexOf("."); //확장자 구분을 위한 (.)인덱스 찾기
			String extension = "."+originalName.substring(index+1); //. 뒤의 확장자를 저장
	        String fileName = UUID.randomUUID().toString(); //DB에 저장될 파일명
	        fileName = fileName.replace("-", "");
	        fileName += extension;
	        String savePath = rootPath + fileName;
	        File destFile = new File(savePath); //최종파일을 업로드 패쓰에 업로드
	        multipartFile.transferTo(destFile);
	        uploadFile.setFileOriginalName(originalName);
	        uploadFile.setFilePath(rootPath);
	        uploadFile.setFileName(fileName);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return uploadFile;
	}
	//파일 삭제
	public boolean deleteImage(String path){
		File destFile = new File(path);
		boolean result = destFile.delete();
		return result;
	}
}
