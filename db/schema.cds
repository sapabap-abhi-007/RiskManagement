namespace sap.ui.riskmanagement;
using { managed } from '@sap/cds/common';
  //using an external service from S/4

  using { API_BUSINESS_PARTNER as bupa } from '../srv/external/API_BUSINESS_PARTNER';

  entity Risks : managed {
    key ID      : UUID  @(Core.Computed : true);
    title       : String(100);
    descr       : String;
    miti        : Association to Mitigations;
    supplier    : Association to Suppliers;
    prio        : String(5);
    impact      : Integer;
    criticality : Integer;
  }
  entity Mitigations : managed {
    key ID       : UUID  @(Core.Computed : true);
    description  : String;
    owner        : String;
    timeline     : String;
    risks        : Association to many Risks on risks.miti = $self;
  }

  entity Suppliers as projection on bupa.A_BusinessPartner {
        key BusinessPartner as ID,
        BusinessPartnerFullName as FullName,
        BusinessPartnerIsBlocked as isBlocked,
  }

