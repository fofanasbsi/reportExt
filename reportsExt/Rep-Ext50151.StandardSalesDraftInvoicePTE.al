reportextension 50151 "StandardSales-DraftInvoice PTE" extends "Standard Sales - Draft Invoice"
{

    // WordLayout = 'Layouts/Sales Report.docx';

    dataset
    {
        add(Line)
        {
            column(vacationAmount; vacationAmount)
            {

            }
            column(DebourAmount; DebourAmount)
            {

            }

            column(VacationAmount_LBL; VacationAmount_LBL)
            {

            }
            column(DebourAmount_LBL; DebourAmount_LBL)
            {

            }



        }
        add(ReportTotalsLine)
        {

            column(TotalVacationAmount; VacationAmountT)
            {

            }
            column(TotalDebourAmount; DebourAmountT)
            {

            }
            column(TotalVacationDebour; TotalVacationDebour)
            {

            }


        }
        add(Totals)
        {
            column(TotalNetAmount_LBL; TotalNetAmount_LBL)
            {

            }
            column(TotalTTCAmount_LBL; TotalTTCAmount_LBL)
            {

            }
            column(TotalAmount_LBL; Total_LBL)
            {

            }

            column(TotalNetAmount_PTE; NetAmount(TotalAmountInclVAT, TotalInvDiscAmount))
            {

            }

        }


        modify(ReportTotalsLine)
        {
            trigger OnAfterAfterGetRecord()
            begin

                if ReportTotalsLine.Description = VATAmountLine.VATAmountText() then begin
                    DebourAmountT := DebourTotalTVA;
                    VacationAmountT := VacationTotalTVA;

                end
                else begin
                    DebourAmountT := DebourTotal();
                    VacationAmountT := VacationTotal();

                end;
                TotalVacationDebour := VacationTotalSumDebourTotal(DebourAmountT, VacationAmountT);

            end;
        }
        modify(Line)
        {
            trigger OnBeforeAfterGetRecord()
            var

                Value: Text;
            begin

                value := CU.FindAccountType(Line."No.", Line.Amount, Line."Amount Including VAT");
                if Value = 'Vacations' then begin
                    VacationAmount := Line.Amount;
                    DebourAmount := 0;
                end
                else
                    if Value = 'Débours' then begin
                        DebourAmount := Line.Amount;//HT;
                        VacationAmount := 0;
                    end
                    else begin
                        DebourAmount := 0;//HT;
                        VacationAmount := 0;
                    end;
            end;

        }
    }


    local procedure DebourTotal(): Decimal

    begin
        exit(CU.TotalDebour());
    end;

    local procedure VacationTotal(): Decimal

    begin
        exit(CU.TotalVacation());
    end;

    local procedure DebourTotalTVA(): Decimal

    begin
        exit(CU.TotalDebourTVA());
    end;

    local procedure VacationTotalTVA(): Decimal

    begin
        exit(CU.TotalVacationTVA());
    end;

    local procedure VacationTotalSumDebourTotal(X: Decimal; Y: Decimal): Decimal

    begin
        exit(X + Y);
    end;

    local procedure NetAmount(TTTCAmount: Decimal; TotalNetAmount: Decimal): Decimal

    begin
        exit(TTTCAmount - TotalNetAmount);
    end;



    var
        VacationAmount: Decimal;
        DebourAmount: Decimal;
        VacationAmount_LBL: Label 'Vacations';
        DebourAmount_LBL: Label 'Débours';
        TotalNetAmount_LBL: Label 'Net à payer';
        TotalTTCAmount_LBL: Label 'Total (TTC)';
        Total_LBL: Label 'Totaux';
        VacationAmountT: Decimal;
        DebourAmountT: Decimal;
        TotalVacationDebour: Decimal;

        CU: Codeunit "Attribute Value MappingCU PTE";


}
