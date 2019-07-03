package vo;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class DatVO {
	private int dat_num;
	private int board_num;
	private String dat_name;
	private String dat_content;
	private Timestamp dat_reg_date;
	private int dat_re_ref;
	private int dat_re_lev;
	private int dat_re_seq;
	
	public int getDat_num() {
		return dat_num;
	}
	public void setDat_num(int dat_num) {
		this.dat_num = dat_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getDat_name() {
		return dat_name;
	}
	public void setDat_name(String dat_name) {
		this.dat_name = dat_name;
	}
	public String getDat_content() {
		return dat_content;
	}
	public void setDat_content(String dat_content) {
		this.dat_content = dat_content;
	}
	public Timestamp getDat_reg_date() {
		return dat_reg_date;
	}
	public void setDat_reg_date(Timestamp dat_reg_date) {
		this.dat_reg_date = dat_reg_date;
	}
	public String dateToString() {
		return new SimpleDateFormat("yyyy/MM/dd").format(dat_reg_date);
	}
	public int getDat_re_ref() {
		return dat_re_ref;
	}
	public void setDat_re_ref(int dat_re_ref) {
		this.dat_re_ref = dat_re_ref;
	}
	public int getDat_re_lev() {
		return dat_re_lev;
	}
	public void setDat_re_lev(int dat_re_lev) {
		this.dat_re_lev = dat_re_lev;
	}
	public int getDat_re_seq() {
		return dat_re_seq;
	}
	public void setDat_re_seq(int dat_re_seq) {
		this.dat_re_seq = dat_re_seq;
	}
	
}
