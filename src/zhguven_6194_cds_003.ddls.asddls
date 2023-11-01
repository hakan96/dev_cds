@AbapCatalog.sqlViewName: 'ZHG_6194_V003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS ODEV 2 ikinci kısım'
define view ZHGUVEN_6194_CDS_003 as select from zhg_6194_v002 as zhg_cds003
{
  key zhg_cds003.vbeln,
      sum( zhg_cds003.conversion_netwr )           as toplam_net_deger,
      zhg_cds003.kunnrad                           as musteri_adsoyad,
      count( * )                                   as toplam_fatura_miktar,
      division(cast( sum( zhg_cds003.conversion_netwr ) as abap.curr( 10,3 ) ),
               cast( count( * ) as abap.int1 ), 3) as ortalama_miktar,
      substring(zhg_cds003.fkdat, 1, 4)            as faturalama_yil,
      substring(zhg_cds003.fkdat, 5, 2)            as faturalama_ay,
      substring(zhg_cds003.fkdat, 7, 2)            as faturalama_gun,
      left(zhg_cds003.inco2_l,3)                   as incoterm_yeri
 
}
 
group by
  zhg_cds003.vbeln,
  zhg_cds003.kunnrad,
  zhg_cds003.fkdat,
  zhg_cds003.inco2_l
 