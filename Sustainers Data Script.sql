
select 
    distinct
    st.ID,
    st.[Marketing Division],
	st.Channel,
	st.[Sub Channel],
	st.[Donor Country],
	st.PaymentMethodSummary,
	st.Pledge_Range as MonthlyGiftRange,
	pay.DepositSite,
    st.[Active/Lost/Lapsing], 
	st.[Status],
	pay.Month_Established,
	pld.Date_Established,
	pay.CloseDate as DateOfPayment,
	pay.Payment as PaymentNumber, --this skips numbers where payments were skipped, shows when there are payment skips
	pay.Months_Elapsed_Since_Pledge, --to cater for time on file??
	st.[Months Prior],
		sum(st.[Monthly Pledge]) as MonthlyPledge,
	pld.CampaignType,
	pld.Market_Source,
	aq.Age as DonorAge,
	count(distinct st.ID) as #Sustainers
into #UKSustainersDataWithPayments
from [dbo].[Status Table] st
left join [dbo].[Payment query] pay
on st.ID = pay.ID
 left join [dbo].[Pledge query] pld
 on st.ID = pld.Donors
 left join [dbo].[Account Query] aq
 on pay.ID = aq.AccountSFID
where st.[Marketing Division]= 'UK Marketing'
--and Month_Established is not null
group by st.[Marketing Division],
    st.ID,
	st.Channel,
	st.[Sub Channel],
		st.[Donor Country],
	st.PaymentMethodSummary,
	st.Pledge_Range,
	pay.DepositSite,
    st.[Active/Lost/Lapsing], 
	st.[Status],
	st.[Months Prior],
	pay.Month_Established,
     pld.Date_Established,
	pay.CloseDate,
	pay.Payment,--this skips numbers where payments were skipped, shows when there are payment skips
	pay.Months_Elapsed_Since_Pledge,	
	st.[Months Prior],
	pld.CampaignType,
	pld.Market_Source,
	aq.Age
--order by st.ID,st.[Months Prior] --pay.CloseDate, --4931 rows


