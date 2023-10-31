codeunit 50150 "Attribute Value MappingCU PTE"

{

    procedure FindAccountType(GLAccount: Code[20]; Mount: Decimal; "Amount Including": Decimal): Text

    begin
        Ref.SetRange("Attribute ID", 7);
        Ref.SetRange("Table ID", 15);
        Ref.FindSet();
        repeat
            if GLAccount = Ref."No." then begin
                if Ref."Attribute Value ID" = 200 then begin
                    TotalD += Mount;
                    TotalDTVA += "Amount Including" - Mount;
                    exit('Débours');
                end
                else
                    if Ref."Attribute Value ID" = 201 then begin
                        TotalV += Mount;
                        TotalVTVA += "Amount Including" - Mount;
                        exit('Vacations');
                    end


            end;
        until Ref.Next() = 0;

    end;

    procedure TotalVacation(): Decimal

    begin
        exit(TotalV);
    end;

    procedure TotalDebour(): Decimal

    begin
        exit(TotalD);
    end;

    procedure TotalVacationTVA(): Decimal

    begin
        exit(TotalVTVA);
    end;

    procedure TotalDebourTVA(): Decimal

    begin
        exit(TotalDTVA);
    end;

    var
        Ref: Record "SCGAM Attribute Value Mapping";
        TotalD: Decimal;
        TotalV: Decimal;
        TotalDTVA: Decimal;
        TotalVTVA: Decimal;







}

