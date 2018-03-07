<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>

        <script type="text/javascript" src="resources/js/jquery.js"></script>

        <script type="text/javascript" src="resources/js/jquery.exif.js"></script>

        <style type="text/css">

        #testimg {

            transform-origin: top left; /* IE 10+, Firefox, etc. */

            -webkit-transform-origin: top left; /* Chrome */

            -ms-transform-origin: top left; /* IE 9 */

        }

        .rotate90 {

            transform: rotate(90deg) translateY(-100%);

            -webkit-transform: rotate(90deg) translateY(-100%);

            -ms-transform: rotate(90deg) translateY(-100%);

        }

        </style>

    </head>

    <body>

        <img id="testimg" style="width:200px;height:200px;display:none;" exif="true" src="resources/files/img/testimg.jpg" style="display:none;" alt="" />

 		<input type="file" name="userImgNew" id="userImgNew4" class="fileInputHidden" accept="image/*" multiple/>

        <script>
		$(document).ready(function(){
			function readURL6(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#testimg').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                        var testimg = $("#testimg");
        				alert(testimg.exif("Orientation"));
                        testimg.addClass("rotate90");
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#userImgNew4").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
               	readURL6(this);
                $("#testimg").css('display','');
              
            	
            });
		})
        
        
       /*  $("#testimg").change(function(){

            setTimeout(function(){

                var testimg = $("#testimg");
				alert(testimg.exif("Orientation"));
                testimg.addClass("rotate90");

               

                testimg.show();

            }, 500);

        });     */

        </script>

    </body>

</html>