using sap.ui.riskmanagement as my from '../db/schema';

//Annotate risk elements

annotate my.Risks with {
    ID          @title : 'Risk';
    title       @title : 'Title';
    descr       @title : 'Description';
    miti        @title : 'Mitigation';
    supplier    @title : 'Supplier';
    prio        @title : 'Priority';
    impact      @title : 'Impact';
    criticality @title : 'Criticality';
}

//Annotate miti elements

annotate my.Mitigations with {
    ID              @( 
                        UI.Hidden, 
                        Common : {
                            Text : description
                                }
                    );
    description     @title : 'Description';
    owner           @title : 'Owner';
    timeline        @title : 'Timeline';
}

//Annotate supplier elements

annotate my.Suppliers with {
    ID              @( 
                        Common : {
                            Text : FullName
                                }
                    );
    FullName     @title : 'Name';
    isBlocked    @title : 'Supplier Blocked';
}

annotate my.Suppliers with @Capabilities.SearchRestrictions.Searchable : false;

annotate my.Risks with {
    miti @( 
                Common : {
        // show text , not id for mitigation in the context of risks
                        Text : miti.description,
                        TextArrangement : #TextOnly,
                        ValueList : {
                                    Label : 'Mitigations',
                                    CollectionPath : 'Mitigations',
                                    Parameters : [
                                                { $Type : 'Common.ValueListParameterInOut',
                                                LocalDataProperty : miti_ID,
                                                ValueListProperty : 'ID'
                                                },
                                                { $Type : 'Common.ValueListParameterDisplayOnly',
                                                ValueListProperty : 'description'
                                                }
                                                ]
                                    }
    }
    );

    supplier @( 
                Common : {
        // show name , not supplier ID for Suppliers in the context of risks
                        Text : supplier.FullName,
                        TextArrangement : #TextOnly,
                        ValueList : {
                                    Label : 'Suppliers',
                                    CollectionPath : 'Suppliers',
                                    Parameters : [
                                                { $Type : 'Common.ValueListParameterInOut',
                                                LocalDataProperty : supplier_ID,
                                                ValueListProperty : 'ID'
                                                },
                                                { $Type : 'Common.ValueListParameterDisplayOnly',
                                                ValueListProperty : 'FullName'
                                                }
                                                ]
                                    }
    }
    )
}


using from './risks/annotations';
using from './common';