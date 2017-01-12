package cn.dahe.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 会员
 * Created by fy on 2016/12/29.
 */
@Table(name = "t_vip")
@Entity
public class Vip {
    @Id
    @GeneratedValue
    private int id;
    //会员编号
    @Column(name = "vip_no")
    private String vipNo;
    //会员姓名
    @Column(name = "vip_name")
    private String vipName;
    //会员折扣
    private String rebate;
    //会员密码
    private String password;
    //会员生日
    private Date birthday;
    //开卡日期
    @Column(name = "create_card_date")
    private Date createCardDate;
    //到期日期
    @Column(name = "due_date")
    private Date dueDate;
    //是否允许赊账 0 不允许 1 允许
    @Column(name = "is_credit")
    private int isCredit;
    //qq
    private String qq;
    //email
    private String email;
    //地址
    private String addr;
    //备注
    private String description;
    //是否启用 0 禁用 1 启用
    private int status;
    //会员余额
    private int balance;
    //会员积分
    private int point;
    //会员等级Id
    @Column(name = "vip_level_id")
    private int vipLevelID;
    //会员等级名称
    @Column(name = "vip_level_name")
    private int vipLevelName;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVipNo() {
        return vipNo;
    }

    public void setVipNo(String vipNo) {
        this.vipNo = vipNo;
    }

    public String getVipName() {
        return vipName;
    }

    public void setVipName(String vipName) {
        this.vipName = vipName;
    }

    public String getRebate() {
        return rebate;
    }

    public void setRebate(String rebate) {
        this.rebate = rebate;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getCreateCardDate() {
        return createCardDate;
    }

    public void setCreateCardDate(Date createCardDate) {
        this.createCardDate = createCardDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public int getIsCredit() {
        return isCredit;
    }

    public void setIsCredit(int isCredit) {
        this.isCredit = isCredit;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }
}
