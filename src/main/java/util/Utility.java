package util;

public class Utility {

	// 답글용 화살표 추가 함수
	public static String arrow(int depth){
		String img = "<img src='./img/arrow.png' width='15px' height='15px' />";
		String nbsp= "&nbsp;&nbsp;&nbsp;&nbsp;";
		
		String ts = "";
		
		for(int i=0; i<depth; i++){
			ts += nbsp;
		}
		
		return depth==0? "" : ts + img;
	}
}
