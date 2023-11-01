@AbapCatalog.sqlViewName: 'ZHG_6194_V002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ODEV 2'
define view ZHGUVEN_6194_CDS_002 as select from vbrp as vb

 inner join vbrk as vk on vb.mandt = vk.mandt and
                          vb.vbeln = vk.vbeln
 inner join mara as ma on vb.mandt = ma.mandt and
                          vb.matnr = ma.matnr
                          
 left outer join vbak as va on vb.mandt = va.mandt and
                               vb.aubel = va.vbeln
                               
 left outer join kna1 as kn on vb.mandt = kn.mandt and
                               va.kunnr = kn.kunnr  
                                                                                
 left outer join makt as mk on ma.matnr = mk.matnr and
                               mk.spras = $session.system_language and
                               vb.mandt = mk.mandt
                               
                       
{
    key vb.vbeln,
    key vb.posnr,
    vb.aubel,
    vb.aupos,
    va.kunnr,
    concat_with_space( kn.name1, kn.name2, 1 ) as kunnrAd,
    currency_conversion( amount  => vb.netwr,
                           source_currency    => vk.waerk,
                           target_currency    => cast( 'EUR'  as abap.cuky ),
                           exchange_rate_date => vk.fkdat ) as conversion_netwr,
      left(va.kunnr, 3)                                     as left_kunnr,
      length( ma.matnr )                                    as length_mara,
      case
          when vk.fkart = 'FAS' then 'Peşinat Talebi İptal'
          when vk.fkart = 'FAZ' then 'Peşinat Talebi'
          else 'Fatura' end                                   as vbrk_fkart,
      vk.fkdat,
      vk.inco2_l
    
    
    
    
    
    
}


