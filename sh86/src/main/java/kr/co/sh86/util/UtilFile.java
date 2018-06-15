package kr.co.sh86.util;

import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.mortennobel.imagescaling.ResampleOp;
import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.MultiStepRescaleOp;

import kr.co.sh86.user.domain.UploadFileDTO;
import net.coobird.thumbnailator.Thumbnails;

public class UtilFile {
	//다중파일업로드
	public List<UploadFileDTO> multiUploadFile(MultipartHttpServletRequest request){
		List<UploadFileDTO> uploadFileList = new ArrayList<UploadFileDTO>();
		//호스팅
		String rootPath = "/home/hosting_users/sh86/tomcat/webapps/files/";
		
		//로컬
		/*String rootPath = "C:\\Users\\FreeUser\\Documents\\workspace-sts-3.9.0.RELEASE\\sh86\\src\\main\\webapp\\resources\\files\\";*/
		
		//회사 서버
		/*String rootPath = "F:\\sh86\\resources\\files\\";*/
		
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
	public UploadFileDTO singleUploadFile(MultipartHttpServletRequest request, String classNum, String type){
		//호스팅
		/*String rootPath = "/home/hosting_users/kis0488/tomcat/webapps/resources/files/"+classNum+"/";*/
		/*String rootPath = "http:///sh86.kr/resources/files/"+classNum+"/";*/
		
		//로컬
		String rootPath = "C:\\Users\\206\\git\\SH86\\sh86\\src\\main\\webapp\\resources\\files\\"+classNum+"\\";
		
		if(type.equals("myPage")) {
			return uploadFile(request.getFile("userImgNew"), rootPath);
		}else if(type.equals("album")) {
			return uploadFile(request.getFile("albumImg"), rootPath);
		}else if(type.equals("photo")){
			return uploadFile(request.getFile("albumImg"), rootPath);
		}else {
			return uploadFile(request.getFile("userImgNew"), rootPath);
		}
	}
	
	// 멀티파트 파일 > 파일 형식으로 변환 (안씀.)
	public File convert(MultipartFile multipartFile) throws IOException {   
	    File file= new File(multipartFile.getOriginalFilename());
	    file.createNewFile();
	    FileOutputStream fos = new FileOutputStream(file);
	    fos.write(multipartFile.getBytes());
	    fos.close();
	    return file;
	}

	//파일업로드 메소드 (DTO반환)
	public UploadFileDTO uploadFile(MultipartFile multipartFile, String rootPath) {
		UploadFileDTO uploadFile = new UploadFileDTO();
		uploadFile.setFilePath(rootPath);
		uploadFile.setFileName(multipartFile.getOriginalFilename().replace("-", ""));
		
		byte[] imgBytes = null;
		try {			
			imgBytes = multipartFile.getBytes(); 
			BufferedInputStream bufferedIS = new BufferedInputStream(new ByteArrayInputStream(imgBytes));
			
			/* Thumbnails 사용시 이미지 색상이 변하는 문제가 생김.
			 * BufferedImage bi = Thumbnails.of(file).scale(1).asBufferedImage();*/
			
			int orientation = correctOrientation(bufferedIS);
			
			BufferedInputStream bis = new BufferedInputStream(new ByteArrayInputStream(imgBytes)); //새로 생성해줘야 bufferedImage가 널이 아니다.
			BufferedImage bi = rotateImageForMobile(bis, orientation);
			
			//분홍배경 색상 원색상으로 보정
			int w = bi.getWidth();
			int h = bi.getHeight();
			BufferedImage biNew = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
			int[] rgb = bi.getRGB(0, 0, w, h, null, 0, w);
			biNew.setRGB(0, 0, w, h, rgb, 0, w);
			
			makeJPG(biNew, new File(rootPath+multipartFile.getOriginalFilename().replace("-", "")));
			/*ByteArrayInputStream byteIS = new ByteArrayInputStream(imgBytes);*/
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (ImageProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MetadataException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		/*try {
			String originalName = multipartFile.getOriginalFilename(); //원래 파일명
	    	int index = originalName.lastIndexOf("."); //확장자 구분을 위한 (.)인덱스 찾기
			String extension = "."+originalName.substring(index+1); //. 뒤의 확장자를 저장.일단안씀
	        String fileName = originalName; //DB에 저장될 파일명
	        fileName = fileName.replace("-", "");
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
		}*/
		return uploadFile;
	}
	//파일 삭제
	public boolean deleteImage(String path){
		File destFile = new File(path);
		boolean result = destFile.delete();
		return result;
	}
	
	
	public static int correctOrientation(BufferedInputStream inputStream) throws ImageProcessingException, IOException, MetadataException {
	    Metadata metadata = ImageMetadataReader.readMetadata(inputStream);
	    int orientation = 1;
	    System.out.println("metadata : "+metadata);
	    if(metadata != null) {
	        // Get the current orientation of the image
            Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
            System.out.println("디렉토리 : "+directory);
            if(directory != null) {
            	orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
                System.out.println("orientation : "+orientation);
                // Create a buffered image from the input stream
            }
        }
	    return orientation;
	}
	
	public BufferedImage rotateImageForMobile(InputStream is,int orientation) throws IOException {
        BufferedImage bi = ImageIO. read(is);
         if(orientation == 6){ //정위치
                return rotateImage(bi, 90);
        } else if (orientation == 1){ //왼쪽으로 눞였을때
                return bi;
        } else if (orientation == 3){//오른쪽으로 눞였을때
                return rotateImage(bi, 180);
        } else if (orientation == 8){//180도
                return rotateImage(bi, 270);      
        } else{
                return bi;
        }       
	}

	public BufferedImage rotateImage(BufferedImage orgImage,int radians) {
        BufferedImage newImage;
         if(radians==90 || radians==270){
               newImage = new BufferedImage(orgImage.getHeight(),orgImage.getWidth(),orgImage.getType());
        } else if (radians==180){
               newImage = new BufferedImage(orgImage.getWidth(),orgImage.getHeight(),orgImage.getType());
        } else{
                return orgImage;
        }
        Graphics2D graphics = (Graphics2D) newImage.getGraphics();
        graphics.rotate(Math. toRadians(radians), newImage.getWidth() / 2, newImage.getHeight() / 2);
        graphics.translate((newImage.getWidth() - orgImage.getWidth()) / 2, (newImage.getHeight() - orgImage.getHeight()) / 2);
        graphics.drawImage(orgImage, 0, 0, orgImage.getWidth(), orgImage.getHeight(), null );
        
         return newImage;
	}
	
	public void makeJPG(BufferedImage orgImage, File destFile) throws IOException {
		/*MultiStepRescaleOp rescale = new MultiStepRescaleOp(orgImage.getWidth(),orgImage.getWidth());
		rescale.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);
		  
		BufferedImage resizedImage = rescale.filter(orgImage, null);*/
		
		ImageIO.write(orgImage, "jpg", destFile);
	}
}
