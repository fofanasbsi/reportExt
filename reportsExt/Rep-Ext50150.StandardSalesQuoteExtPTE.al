reportextension 50150 "Standard Sales - QuoteExt PTE" extends "Standard Sales - Quote"
{
    //WordLayout = 'Layouts/Sales Report.docx';

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
        add(LetterText)
        {
            column(Text000LBL_PTE; Text000_PTE)
            {

            }
            column(Text001LBL_PTE; Text001_PTE)
            {

            }
            column(Text002LBL_PTE; Text002_PTE)
            {

            }
            column(Text003LBL_PTE; Text003_PTE)
            {

            }
            column(Text004LBL_PTE; Text004_PTE)
            {

            }
            column(Text005LBL_PTE; Text005_PTE)
            {

            }
            column(Text006LBL_PTE; Text006_PTE)
            {

            }
            column(Text007LBL_PTE; Text000_PTE + Text001_PTE + Text002_PTE + Text003_PTE + Text004_PTE + Text005_PTE + Text006_PTE)
            {

            }

        }
        modify(ReportTotalsLine)
        {
            trigger OnAfterAfterGetRecord()
            var
                StatusDescription: Boolean;
            begin

                if ReportTotalsLine.Description = VATAmountLine.VATAmountText() then begin
                    DebourAmountT := DebourTotalTVA;
                    VacationAmountT := VacationTotalTVA;
                    TotalVacationDebour := VacationTotalSumDebourTotal(DebourTotalTVA, VacationTotalTVA);
                end
                else begin
                    DebourAmountT := DebourTotal();
                    VacationAmountT := VacationTotal();
                    TotalVacationDebour := VacationTotalSumDebourTotal(DebourTotal(), VacationTotal());
                end;
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

    local procedure NetAmount(TTTCAmount: Decimal; TotalNetAmount: Decimal): Decimal

    begin
        exit(TTTCAmount - TotalNetAmount);
    end;

    local procedure VacationTotalSumDebourTotal(X: Decimal; Y: Decimal): Decimal

    begin
        exit(X + Y);
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
        VATTable: Record "VAT Amount Line";
        Count: Integer;
        TotalVacationDebour: Decimal;
        Text000_PTE: Label 'Le debiteur professionel des sommes dues, qui ne seraient pas reglees a bonne date, est redevable de plein droit de penalites de retard d''un montant egal au taux d''interet applique ';
        Text001_PTE: Label 'par la Banque europeenne a son operation de refinancement la plus recente majoree de 5 points de pourcentage et d''une indemnite forfaitaire pour frais de recouvrement d''un ';
        Text002_PTE: Label 'montant de 40 euros.(Art. D.441-5 du Code de commerce) ';
        Text003_PTE: Label ' La T.V.A. est acquittee sur la regime des encaissements. ';
        Text004_PTE: Label 'TVA Intracommunautaire numéro FR8740189934900021 ';
        Text005_PTE: Label 'Bank Info: BANQUE CIC - SWIF CMCIFRPP - IBAN No. FR7630066107710001037930172 ';
        Text006_PTE: Label 'SAB FORMALITES - 23, rue du Roule 75001 PARIS - RCS 401 899 349 Code APE 741 A - Tel: 01.45.08.58.89';

        CU: Codeunit "Attribute Value MappingCU PTE";


}
