--2021年主营非码号收入构成
select b.zbbm,b.zbbm_name,flg4,flg5,sum(aft_tax_amt) from app_a.ljz_income_2021_jd a
left join app_a.jd_fangw_zbbm_list_2021_aft06 b
on a.sub_code=b.zbbm
where a.zhuying_flg in ('1','2') and a.mh_income_flg<>'1'
group by  b.zbbm,b.zbbm_name,flg4,flg5

select * from  app_a.jd_fangw_zbbm_list_2021_aft06 b
select * from app_a.jd_dhhm_202112 b limit 111
select * from zjbic.ofr_main_asset_cur_a c limit 111
select * from app_a.ljz_income_202201_jd limit 100

--取出政企2021年存增量移动收入 20220126
select a.acct_month,b.zhiju_t0,
(case when b.SERV_START_DT>=Date'2021-01-01' then '增量' else '存量' end ) ,
sum(aft_tax_amt) 移动收入
from app_a.ljz_income_2021_jd a
left join app_a.jd_dhhm_202112 b
on a.asset_integ_id=b.asset_integ_id
left join zjbic.ofr_main_asset_cur_a  c
on a.asset_integ_id=c.asset_integ_id
where c.corp_user_name='政企客户'
and c.cprd_name='移动电话'
and a.zhuying_flg in ('1','2')
group by a.acct_month,b.zhiju_t0,(case when b.SERV_START_DT>=Date'2021-01-01' then '增量' else '存量' end ) 

--未落地资产认领
select * from app_a.ljz_zcrl_1
select * from app_a.ljz_zcrl_1 where ccust_name like '%建德%' or addr_name like '%建德%' 
select * from app_a.ljz_zcrl_jd

--系统收入
 select d.sn_tb,d.zj_name 支局
       ,sum(a.aft_tax_amt) as 主营收入 
       ,sum(case when a.mh_income_flg_n=1  then a.aft_tax_amt else 0 end ) as 码号收入
       ,sum(case when c.产数<>''  then a.aft_tax_amt else 0 end ) as 产数收入   
       ,sum(case when c.产数='' and a.mh_income_flg_n<>1 then a.aft_tax_amt else 0 end ) as 非产数非码号收入 
  from app_a.ljz_income_202201_jd  a
 left join app_a.jd_dhhm_202201 b 
 on a.asset_integ_id=b.asset_integ_id 
 left join   app_a.dbq_zbbm_list_2022_txm  c
 on a.sub_code=c.zbbm 
 left join  app_a.phh_zj_info_2021_10 d
 on b.lv1_zhiju=d.zj_name
where  c.flg1 in ('移动主营','固网主营')  
and a.rule_name NOT IN (
'0301','0303','0306','0307','0404','0501','0502','0504','0507','0508','0509','0510','0511','0512','0513',
'0602','0603','0604','0701','0702','0801','1001','1002','1003','2002','2003','2004','2005',
'3001','3002','3003','3004','3005','3006','4001','4002','4003','4005','6001','6002','6003','6004','6011',
'7001','7002','7003','9001','9002')
group by d.sn_tb,d.zj_name 
order by  d.sn_tb;
--手工收入
 select d.sn_tb,d.zj_name 支局
       ,sum(a.aft_tax_amt) as 主营收入 
       ,sum(case when c.产数<>''  then a.aft_tax_amt else 0 end ) as 产数收入 
       ,sum(case when c.产数='' then a.aft_tax_amt else 0 end ) as 非产数非码号收入 
  from app_a.jd_caibao_202201_sg  a
 left join   app_a.dbq_zbbm_list_2022_txm  c
 on a.sub_code=c.zbbm 
 left join  app_a.phh_zj_info_2021_10 d
 on a.area_id_c5=d.c5_id
where  c.flg1 in ('移动主营','固网主营')  
group by d.sn_tb,d.zj_name 
order by  d.sn_tb;

--大企业支局调整vip2021年收入取数
select b.lv1_zhiju,b.vip_nbr,sum(aft_tax_amt) from app_a.ljz_income_202201_jd a
left join app_a.jd_dhhm_202201 b
on a.asset_integ_id=b.asset_integ_id
where b.vip_nbr in (
'571J282615',
'571J1247066',
'571J1317074',
'571J1404421',
'571J665247',
'571J025240',
'571J025312',
'571J1354657',
'571J1335570'
)
group by b.lv1_zhiju,b.vip_nbr



--未落地资产清单
select * from  APP_A.jd_dhhm_202201 a
left join zjbic.ofr_main_asset_cur_a b
on a.asset_integ_id=b.asset_integ_id
 where lv1_zhiju like '%未落地%' and a.stat_name<>'不活动'
 
--自己落地和杭州落地差异
select * from app_a.ljz_income_202201 where 
 select zj_area_name 杭州落地,a.lv1_zhiju,a.asset_integ_id,a.vip_nbr,a.stat_name from app_a.jd_dhhm_202201 a
 left join app_a.ofr_main_asset_mon_jd b
 on a.asset_integ_id=b.asset_integ_id
  where b.bil_month='202201'  and zj_area_name<>lv1_zhiju
  and a.asset_integ_id<>'-1'
  and a.stat_name<>'不活动'
  
select * from app_a.jd_dhhm_202201 where vip_nbr='571J1266712' and stat_name<>'不活动';

 select * from zjbic.ofr_main_asset_cur_a b limit 100
 select * from app_a.dbq_zbbm_list_2022_txm order by seq
 
 select from app_a.ljz_income_202201_jd a 
 left join  app_a.dbq_zbbm_list_2022_txm  b
 on a.sub_code=b.zbbm
 
 select d.sn_tb,d.zj_name 支局
       ,sum(a.aft_tax_amt) as 主营收入 
       ,sum(case when c.产数<>''  then a.aft_tax_amt else 0 end ) as 产数收入   
  from app_a.jd_caibao_202201_sg  a
 left join   app_a.dbq_zbbm_list_2022_txm  c
 on a.sub_code=c.zbbm 
 left join  app_a.phh_zj_info_2021_10 d
 on a.area_id_c5=d.c5_id
where  c.flg1 in ('移动主营','固网主营')  
group by d.sn_tb,d.zj_name 
order by  d.sn_tb
select * from app_a.ljz_in

--
CREATE TABLE
    APP_A.jd_caibao_202201_buding  AS
    (
                SELECT     *    FROM    app_a.ljz_income_202201_jd 
                where 1=2
    )
ORDER BY
    area_id_lv5 segmented BY hash
    (
        area_id_lv5
    )
    ALL nodes ksafe 1;   
    
--取2021年台阶收入
SELECT sn_tb,    b.zj_name,   SUM(a.aft_tax_amt)/10000
FROM     app_a.v_ys_income_taijie_71_jd a
left join app_a.jd_dhhm_202201 c
on a.asset_integ_id=c.asset_integ_id    
LEFT JOIN     APP_A.phh_zj_info_2021_10 b
ON    c.lv1_zhiju=b.zj_name
WHERE     a.acct_month='202105'  AND a.is_taijie='Y'
GROUP BY     b.sn_tb,b.zj_name
order by     b.sn_tb;      
--取某个子产品
select a.asset_row_id,b.accs_nbr ,b.asset_row_id,c.stat_name ,c.cprd_name  
from app_a.hwj_temp a 
left join zjbic.ofr_main_asset_cur_a b
on a.asset_row_id=b.accs_nbr
left join  zjbic.ofr_child_asset_cur_a   c
on b.asset_row_id=c.Root_Asset_Row_Id
where b.stat_name<>'不活动'
and c.stat_name<>'不活动'
and c.cprd_name='号百云产品'

select * from  app_a.v_detail_data_cb_2021t0_jd  limit 111

select * from zjbic.ofr_child_asset_cur_a   c limit 11


select b.lv1_zhiju,b.cacct_id,b.accs_nbr,a.aft_tax_amt
 from app_a.ljz_income_202201_jd a
left join app_a.jd_dhhm_202201 b
on a.asset_integ_id=b.asset_integ_id
where b.cacct_id='2712029848314'

select * from app_a.hz_share_2022 where bill_id_resets='712022010116351001033'

--调账金额统计
select acct_month,lv1_zhiju,sum(aft_tax_amt) 调账金额
from app_a.ljz_income_202201_jd a
left join app_a.jd_dhhm_202201 b
on a.asset_integ_id=b.asset_integ_id
 left join APP_A.ljz_rulename c
 on a.rule_name=c.srly
where rule_name='5002' 
group  by acct_month, b.lv1_zhiju
order by lv1_zhiju,acct_month

--看家取数
      select root_asset_row_id,
      b.asset_row_id,
      c.accs_nbr,
      b.serv_start_dt,
      c.user_name,
      c.addr_name,
      d.area_name_lv5,d.area_name_lv6,d.area_name_lv7 
      from  zjbic.OFR_CHILD_ASSET_CUR_a b
      left join zjbic.ofr_main_asset_cur_a c
      on b.root_asset_row_id=c.asset_row_id
      left join     app_a.loc_area_tree_ndep_mon_a d
      on c.area_id=d.area_id
      where  month_cd='202201'
          AND d.area_id_lv4='647'
          and b.serv_start_dt>='2022-01-01' 
          and b.cprd_name='天翼看家' and b.stat_name<>'不活动'
          
--核查VIP对应资产的落地信息
SELECT 
    B.ASSET_INTEG_ID, 
    b.cprd_name,
    b.serv_start_dt,
    C.VIP_NBR , 
    b.area_merge_name
FROM 
    zjbic.ofr_main_asset_cur_a B ,
    app_a.par_cust_cur_a       C
WHERE 
    B.CCUST_ROW_ID=C.CCUST_ROW_ID
AND c.vip_nbr='571J1021339'
and b.stat_name<>'不活动'

--部门名称对应ID
select * from bssdata.PAR_DEPT  where dept_name like '%建德政企%' and agent_state='在用'  

--付费资产数统计
select b.lv1_zhiju,--b.vip_nbr,b.vipname,a.accs_nbr,a.cacct_id,
sum(case when Pay_Mode_Cd=1 then 1 else 0 end ) 后付费,
sum(case when Pay_Mode_Cd=2 then 1 else 0 end ) 预付费 ,
round(sum(case when Pay_Mode_Cd=2 then 1 else 0 end )/count(*)*100,4)||'%' 预付费占比
 from app_a.ofr_main_asset_cur_jd  a
left join app_a.jd_dhhm_202202 b
on a.asset_integ_id=b.asset_integ_id 
where a.stat_name='现行'
group by b.lv1_zhiju
order by  后付费

--同客户下合同号
select b.ccust_id,ccust_name,c.cacct_id,c.cacct_name 
from zjbic.PAR_CUST_CUR_A b 
inner join BSSDATA.FIN_CACCT_BSI_HIST_A c
on b.ccust_row_id =c.ccust_row_id and c.end_dt=date'3000-12-31' and c.cacct_stat_name='有效'
where b.${tj} in (${val});

----202005-亲情卡10元副卡包_ZJ   318459400 跨客户共享套餐
CREATE LOCAL TEMPORARY TABLE cyf_scb_sjtb_new_201612_list77  ON COMMIT PRESERVE ROWS 
AS
(
select  distinct p1.prom_integ_id z_prom_inetg_id,p5.prom_integ_id,p5.prom_name 
from  (select distinct asset_row_id,prom_integ_id from cyf_scb_sjtb_new_201612_list1 ) p1
inner   join zjbic.evt_cust_std_prom_a p3 
on p1.asset_row_id=p3.tpc_asset_row_id and p3.prom_row_id in ('318459400') and p3.io_flg='I' and p3.last_stat_name='竣工'
inner   join ZJBIC.ofr_asset_prom_cur_a p2
on p3.tpc_asset_row_id=p2.asset_row_id and p3.prom_row_id=p2.prom_row_id and p3.pdm_prom_integ_id=p2.pdm_prom_integ_id and  p2.stat_name='有效' 
inner join bssdata.ofr_prom_exi_hist_a  p4
on p2.prm_inst_id=p4.prom_instant_row_id and p4.end_dt=date'3000-12-31' and trim(p4.val_type_name)='跨客户共享套餐'
inner join zjbic.ofr_asset_main_cdsc_cur_a  p5
on p4.val=p5.prom_integ_id and p5.stat_name='有效'
inner join ZJBIC.ofr_main_asset_cur_a  p6
on p5.asset_row_id=p6.asset_row_id and  p6.stat_name<>'不活动' and p6.cprd_name='移动电话'
)
ORDER BY z_prom_inetg_id 
SEGMENTED BY HASH(z_prom_inetg_id) ALL NODES ;


--千兆厚覆盖小区
select area_id,'接入号:'||accs_nbr,speed,prom_name from zjbic.ofr_main_asset_cur_a a,zjbic.ofr_asset_main_cdsc_cur_a B 
 where  a.asset_row_id=b.asset_row_id  and a.stat_name<>'不活动'
 and a.cprd_name='有线宽带'
 and area_id in (
'129043','122091','121895','121990','121934','121952','126154','126155','121937','121955','122072',
'130819','122081','212516','212517','126161','126159','121961','212515','121957','121936','122075',
'121949','122079','122078','121944','121898','121953','130867','121943','121956','121938','126156',
'121897','122030','121093','122038','121986','122077','130820','118595','122088','121892','121968',
'121992','121998','117621','121982','122066','126153','121999','121939','121973','121932','117617',
'122084','122127','118666','130824','121983','117619','121972','121966','121987','122090','117620',
'121979','121900','122070','121945','121993','121954','130822','122082','122028','117615','122092',
'121980','121967','121997','127334','121977','121965','121974','121978','122029','117616','121893',
'121996','127335','122031','121971','121960','121969','121975','121976','121940','121995',
'121933','121959','126160','121947','121930','121928','121985','121991','121964','130869',
'122068','121970','122076','121962','126157','130823','121929','121981','130755','121951',
'121963'
 ) order by area_id

--统计闪耀缺口数
select a.area_id,b.area_name,b.area_name_lv5,(count(*)) 宽带数,
(sum(case when speed='1024000Kbps' then 1 else 0 end)) 千兆宽带数,
(sum(case when speed='1024000Kbps' then 1 else 0 end) /count(*))  千兆宽带占比,
(ceil(count(*) *0.3-sum(case when speed='1024000Kbps' then 1 else 0 end) )) 缺口数
from zjbic.ofr_main_asset_cur_a a
left join  app_a.loc_area_tree_ndep_mon_a  b 
 on  a.area_id=b.area_id
 where a.stat_name<>'不活动'
 and a.cprd_name='有线宽带'
 and a.area_id in (
'129043','122091','121895','121990','121934','121952','126154','126155','121937','121955','122072',
'130819','122081','212516','212517','126161','126159','121961','212515','121957','121936','122075',
'121949','122079','122078','121944','121898','121953','130867','121943','121956','121938','126156',
'121897','122030','121093','122038','121986','122077','130820','118595','122088','121892','121968',
'121992','121998','117621','121982','122066','126153','121999','121939','121973','121932','117617',
'122084','122127','118666','130824','121983','117619','121972','121966','121987','122090','117620',
'121979','121900','122070','121945','121993','121954','130822','122082','122028','117615','122092',
'121980','121967','121997','127334','121977','121965','121974','121978','122029','117616','121893',
'121996','127335','122031','121971','121960','121969','121975','121976','121940','121995',
'121933','121959','126160','121947','121930','121928','121985','121991','121964','130869',
'122068','121970','122076','121962','126157','130823','121929','121981','130755','121951',
'121963' )  
 and b.month_cd='202206' 
 group by a.area_id,b.area_name,b.area_name_lv5
 order by 缺口数

--码号收入分收入源统计
select a.acct_month,b.lv1_zhiju,c.NAME,cust_flg,sum(aft_tax_amt) 
from app_a.ljz_income_2022_jd a,app_a.jd_dhhm_202209 B,app_a.ljz_rulename c
where a.asset_integ_id=b.asset_integ_id
and a.rule_name=c.SRLY
and a.mh_income_flg_n=1
group by a.acct_month,b.lv1_zhiju,c.NAME,cust_flg

--新增套餐收入
select a.prom_asset_integ_id,b.accs_nbr,sum(c.aft_tax_amt) fee09,sum(d.aft_tax_amt) fee08
from   app_a.ofr_main_asset_mon_jd a 
left join app_a.jd_dhhm_202209 b
on a.prom_asset_integ_id=b.prom_asset_integ_id
left join app_a.ljz_income_202209_jd c
on b.asset_integ_id=c.asset_integ_id
left join app_a.ljz_income_202208_jd d
on b.asset_integ_id=d.asset_integ_id
left join  app_a.phh_zj_info_2021_10 e
on b.lv1_zhiju=e.zj_name
where a.mix_cdsc_flg=1 and add_card_flg=0  and a.cprd_name='移动电话' and a.bil_month='202209'   
and a.serv_start_dt >= date'20220901' and  a.serv_start_dt <=date'20220930'
and b.lv1_zhiju='建德乾潭支局'
group by a.prom_asset_integ_id,b.accs_nbr

--
--发展质态分析2022年
select d.lv1_zhiju 建德落地口径,a.std_prd_lvl4_name,a.cprd_name,a.stat_name,a.accs_nbr,a.cacct_id,a.serv_start_dt,a.serv_end_dt,
zj_area_name 杭州落地口径,dept_name,oneway_stop_dt,twoway_stop_dt,prom_name,mix_comb_nbr_flg 副卡标志,
out_net_type,mkt_employee_id,
b.qf_sum,b.qf_usum,b.back_sum,b.back_csum,b.billing_cycle_id,
sum(case when c.acct_month='202201' then (c.aft_tax_amt) else 0 end) f01,
sum(case when c.acct_month='202202' then (c.aft_tax_amt) else 0 end) f02,
sum(case when c.acct_month='202203' then (c.aft_tax_amt) else 0 end) f03,
sum(case when c.acct_month='202204' then (c.aft_tax_amt) else 0 end) f04,
sum(case when c.acct_month='202205' then (c.aft_tax_amt) else 0 end) f05,
sum(case when c.acct_month='202206' then (c.aft_tax_amt) else 0 end) f06,
sum(case when c.acct_month='202207' then (c.aft_tax_amt) else 0 end) f07,
sum(case when c.acct_month='202208' then (c.aft_tax_amt) else 0 end) f08,
sum(case when c.acct_month='202209' then (c.aft_tax_amt) else 0 end) f09,
sum(case when c.acct_month='202210' then (c.aft_tax_amt) else 0 end) f10,
sum(case when c.acct_month='202211' then (c.aft_tax_amt) else 0 end) f11,
sum(case when c.acct_month='202212' then (c.aft_tax_amt) else 0 end) f12
 from app_a.ofr_main_asset_mon_jd a 
left join app_a.dbq_pxl_qf_list_202209_tm b
on a.asset_integ_id=b.asset_integ_id
left join app_a.ljz_income_2022_jd c
on a.asset_integ_id=c.asset_integ_id
left  join app_a.jd_dhhm_202209 d
on a.asset_integ_id=d.asset_integ_id
where a.bil_month='202209'  and a.serv_start_dt>=date('2022-01-01')
and a.cprd_name in ('ITV','移动电话','有线宽带','普通电话')
group by d.lv1_zhiju,a.std_prd_lvl4_name,a.cprd_name,a.stat_name,a.accs_nbr,a.cacct_id,a.serv_start_dt,a.serv_end_dt,
zj_area_name,dept_name,oneway_stop_dt,twoway_stop_dt,prom_name,mix_comb_nbr_flg ,
out_net_type,mkt_employee_id,
b.qf_sum,b.qf_usum,b.back_sum,b.back_csum,b.billing_cycle_id


--赠金分析
select acct_month,b.lv1_zhiju,c.corp_user_name,sum(aft_tax_amt) 赠金 from app_a.ljz_income_2021_jd A
left JOIN app_a.jd_dhhm_202201 B
on a.asset_integ_id=b.asset_integ_id
left join app_a.ofr_main_asset_mon_jd C
on a.asset_integ_id=c.asset_integ_id
where a.mh_income_flg_n=1
and a.rule_name='5003'
and c.bil_month='202201'
group by acct_month,b.lv1_zhiju,c.corp_user_name

select b.vip_nbr,b.vipname
,sum(case when a.acct_month='202201' then a.aft_tax_amt else 0 end ) as f202201
,sum(case when a.acct_month='202202' then a.aft_tax_amt else 0 end ) as f202202
,sum(case when a.acct_month='202203' then a.aft_tax_amt else 0 end ) as f202203
,sum(case when a.acct_month='202204' then a.aft_tax_amt else 0 end ) as f202204
,sum(case when a.acct_month='202205' then a.aft_tax_amt else 0 end ) as f202205
,sum(case when a.acct_month='202206' then a.aft_tax_amt else 0 end ) as f202206
,sum(case when a.acct_month='202207' then a.aft_tax_amt else 0 end ) as f202207
,sum(case when a.acct_month='202208' then a.aft_tax_amt else 0 end ) as f202208
,sum(case when a.acct_month='202209' then a.aft_tax_amt else 0 end ) as f202209
from app_a.jd_dhhm_202209 B,app_a.ljz_income_2022_jd A
, app_a.ofr_main_asset_mon_jd C, zjbic.ofr_main_asset_cur_a d
where 
b.asset_integ_id=a.asset_integ_id
and b.asset_integ_id=c.asset_integ_id
and b.asset_integ_id=d.asset_integ_id
and a.mh_income_flg_n=1
and a.rule_name='5003'
and c.bil_month='202209'
and b.lv1_zhiju ='建德大企业支局'
group by  b.vip_nbr,b.vipname


select b.vip_nbr,b.vipname
,sum(case when bb.acct_month='202101' then bb.aft_tax_amt else 0 end ) as f202101
,sum(case when bb.acct_month='202102' then bb.aft_tax_amt else 0 end ) as f202102
,sum(case when bb.acct_month='202103' then bb.aft_tax_amt else 0 end ) as f202103
,sum(case when bb.acct_month='202104' then bb.aft_tax_amt else 0 end ) as f202104
,sum(case when bb.acct_month='202105' then bb.aft_tax_amt else 0 end ) as f202105
,sum(case when bb.acct_month='202106' then bb.aft_tax_amt else 0 end ) as f202106
,sum(case when bb.acct_month='202107' then bb.aft_tax_amt else 0 end ) as f202107
,sum(case when bb.acct_month='202108' then bb.aft_tax_amt else 0 end ) as f202108
,sum(case when bb.acct_month='202109' then bb.aft_tax_amt else 0 end ) as f202109
,sum(case when bb.acct_month='202110' then bb.aft_tax_amt else 0 end ) as f202110
,sum(case when bb.acct_month='202111' then bb.aft_tax_amt else 0 end ) as f202111
,sum(case when bb.acct_month='202112' then bb.aft_tax_amt else 0 end ) as f202112
from app_a.jd_dhhm_202209 B,app_a.ljz_income_2021_jd bb
, app_a.ofr_main_asset_mon_jd C, zjbic.ofr_main_asset_cur_a d
where 
b.asset_integ_id=bb.asset_integ_id
and b.asset_integ_id=c.asset_integ_id
and b.asset_integ_id=d.asset_integ_id
and bb.mh_income_flg_n=1
and bb.rule_name='5003'
and c.bil_month='202209'
and b.lv1_zhiju ='建德大企业支局'
group by  b.vip_nbr,b.vipname

--漫游取数
  select acct_month,area_name_lv5,sum(aft_tax_amt) from app_a.ljz_income_2022_jd
   where rule_name='0501' AND sub_code in ('1027','1085','1197') and asset_integ_id='-1'
  group by acct_month,area_name_lv5


  ---
  truncate table app_a.phh_temp_asset_integ_id  ;
  select a.*,b.ASSET_INTEG_ID,cprd_name  from  app_a.phh_temp_asset_integ_id  a 
  left join app_a.jd_dhhm_202210 b
  on a.asset_integ_id=b.accs_nbr

where accs_nbr in (
  '57164190997',
'712YZMFY03856573',
'ACMB8330100000714064',
'57163309864',
'hzjdyxm6417',
'13306520762',
'57164065088',
'057164100517',
'057115125067',
'057126353358',
'057126353364',
'057126353356',
'057125284089',
'57164593813',
'057111088424',
'057171170014',
'057171169904',
'057171092632',
'057171170082',
'057171134449',
'057171110708',
'057171134413',
'057171148147',
'057171148147',
'057171148146',
'057171094474',
'057170958143',
'057171065676',
'057171080239',
'057171535206',
'057171149795',
'057171065238',
'057171134448',
'057171024044',
'057171170083',
'057171086898',
'057171010760',
'057171148146',
'057171134414',
'057171058828',
'57131750706',
'32010169430003')

--创收根据订单核对
select * from app_a.ljz_income_2022_jd 
where asset_integ_id in (select serv_code from app_a.hz_list_2022  
                         where bill_id_resets='712022102912243502443')



--
select acct_month,sum(aft_tax_amt) from app_a.ljz_income_2022_jd a 
where    a.mh_income_flg_n<>1 and  a.cyszh_flg<>1 
group by a.acct_month


select * from
app_a.ljz_income_2022_jd a ,app_a.dbq_zbbm_list_2022_txm_aft08  c,app_a.jd_dhhm_202210 b
where    a.mh_income_flg_n<>1 and  a.cyszh_flg<>1 
 and a.sub_code=c.zbbm 
 and a.asset_integ_id=b.asset_integ_id


select a.rule_name,sum(aft_tax_amt) from
app_a.ljz_income_2022_jd a ,app_a.dbq_zbbm_list_2022_txm_aft08  c,app_a.jd_dhhm_202210 b,
app_a.ljz_rulename d
where    a.mh_income_flg_n<>1 and  a.cyszh_flg<>1 
 and a.sub_code=c.zbbm 
 and a.asset_integ_id=b.asset_integ_id
group by rule_name