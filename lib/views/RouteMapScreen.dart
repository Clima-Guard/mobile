
import 'package:clima_guard_mobile/views/widgets/GoogleMapWidget.dart';
import 'package:clima_guard_mobile/views/widgets/RecommendationContainerWidget.dart';
import 'package:clima_guard_mobile/views/widgets/RouteDetailsCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapScreen extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String origin;
  final String destination;
  final List<String> waypoints;

  const RouteMapScreen({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.origin,
    required this.destination,
    required this.waypoints,
  });

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {

  final List<LatLng> interpolatedPoints = [
    LatLng(46.56485000000001, 23.797150000000002),
    LatLng(46.58868565048134, 23.7560179806133),
    LatLng(46.62867774931938, 23.711636744704812),
    LatLng(46.66344411579769, 23.661997590113007),
    LatLng(46.70224425361693, 23.615851802460277),
    LatLng(46.73955314190706, 23.59141961870642),
    LatLng(46.77102000000001, 23.624060000000007)
  ];

  final String polyline = "iue{Ge{fpCBM@I@U@U?K@IC_@E{@A[AQ?KAG?E?E?E@K@GBI@ELIJC^G`@I^Ef@KFv@b@lEVvAd@`CXpAHv@Bl@Bz@?r@ApB?j@Ah@?DCRAPCNEPGRUt@{@nCM`@c@`ACF[f@[d@}@vAw@~@q@v@yAhBeCdDIHiAzAOJQFSBS@G~@sAOw@Mi@Mg@Sk@UOCKAM?K@KFIFIHGHIHGLILGRGTGVCZARCX?L?F?ZBNB`@XrBF^Jp@Lx@IZCACAC?C?C@C@CBABCB?DAD?D?D?B@D@F@BBBB@B@B@B?BABAj@ZDLZ~@VhAJ^Pd@Vh@l@|@dApATZX`@^p@Zt@N`@Xp@ADg@DQDGF[Ga@KIAMEk@IGCOA_@Eu@AeA?s@@gCFS?eBBs@EcAEaAEq@?]A]?S?M@[@i@FEBg@Je@Re@RQJUJg@Xc@Xo@d@_BvAe@`@UTYZW\\\\[`@SZININYr@s@zBe@jBM`AC\\\\Ij@Iz@a@lDMlAc@fFa@~DAJCXOpAMdAu@rFEZETGTEPCHCDCDC?G?EAGAEAGCOMUUw@u@cAaA_A_AqAsAYYECG@G@C@EBCFEHo@pBUx@Kf@GZAFEZEb@MrBAXKzBOxBOzBK~@Ef@O~@Kr@CNGVGVITGLMLONSPg@`@y@r@_@b@c@h@kBdCy@bAo@p@e@`@w@t@_@b@y@bAOTOVQ^_@x@[|@Sh@e@dAi@dA_AzAqAfBU\\\\y@jAo@hA}@vAo@dAyA|BuCxE{BrD{AbCYb@i@|@aBjCoArBCDk@|@EH{@zAMVCDGNEFu@hBEHKDOVcA~Cm@hBKVk@bBqB~FWn@Un@EDUf@EHY`@UXo@l@cCtBuDbD_@\\\\ON}@t@_@XED_Ax@wAlAEDYRyBdBkCfBGDGDEBGDwAdAiClBMHo@`@cGlDoFjD{@l@{EdD]T]R_BlAkB~A}@z@kAlAuApAkAfAi@d@cC~BeD|C_@\\\\eAdAa@b@IH[^[`@QTIJ]d@S\\\\}@tAq@dA]j@a@r@]t@KXQ`@]~@aBzEM\\\\}BpGEHM^Sj@a@jAm@`BUf@KVEDKTW^UZi@f@]R[La@L[HS@OB_@Bu@@qB?iABE@EDS?S@c@Fe@H_@Fe@P_A^cAf@{Av@YLs@`@s@d@CB_@Xw@t@g@h@W\\\\i@t@o@dAa@v@wBfEm@dAa@z@a@p@u@nAKNMTqAzBkAnBs@lAOVc@v@_@h@IJABWZi@p@ONA@WTa@^WTCBg@^s@d@[RiAt@_@VYPEDULSNsBrAo@`@i@\\\\c@Xs@f@C@MJSREBMLGFUZIJEFCBEFCDWb@Ub@GLGP_@fAEJM^IZEJM\\\\ENKViBxFMPELw@tCi@~BCPCJALETS`AaBxKgAhIs@xEs@`FQ`Ac@tCGT}@nFc@dCaAbFqAxGa@hBId@Sv@CJW`AERGP]pAGRYbAo@~B_@hAqA`Ee@nASl@g@vA[z@KVOZWd@c@n@QPQRe@\\\\OL{AfAm@`@[Tq@h@E?E@C@E@CBCDCDCDAFAF[p@]`AO`@ITOf@IZK^w@fCSjAc@vAM`@EJGP{@nCCJEHCJCFEHIRCDYf@U`@OROTKJUXONOP_@ZONYT[T_@X}At@WNQH_A`@iBt@QF_EtAa@N}@ZSFkA`@e@PaBh@aA\\\\m@X[NQLYTSR[ZYb@MDA@EF]l@Wp@Od@IZKZKf@ETCVKl@W~AWpBG^Ib@YfA]z@Sf@KV_@j@_@j@QRYXkAbAQLOJ[Tk@d@k@b@k@h@e@f@UZWXGHINU`@MRw@pAm@bAQVSX_@b@QVSRe@f@OLs@j@YRIFc@\\\\cBhASLQL]TQN{@n@cAn@}@n@_Al@SPKHIFUROJOLKHSPcA|@WXy@|@q@z@QTW\\\\U^GFCDKRYh@]r@e@jAM^Kd@W~@]rAUdAMd@Qp@Up@s@hBe@`A_@h@MNQLa@X_@PSFEB{@NsBTsBT[Dg@L[H]JUJe@To@^_@VGDWLs@^_@V_@TYN_@P{@`@{Ar@q@X_@RUN[R_@Zg@d@u@z@_@d@u@~@CBMPUZg@l@[d@m@|@c@p@MTMTU^kAtBGJMTEHGHW`@SZg@r@g@n@s@z@g@j@k@t@]d@Yb@Wd@Wd@Wp@MZMb@Qn@W~@YlAGRGTWz@Of@Sb@S^QZWZ[ZWT]T[N_@Tw@^a@L]NmCnA]Rm@b@qAfAYXq@r@WZY\\\\Yb@Yf@Uf@k@hACFADAB?Ja@`A[p@u@xA_@x@U`@q@bB]p@mAdC}@nBKXEHEH}AdDgCvF_@v@w@|Ay@|AaAjBYd@a@r@G@EBEDGLmA~Bu@tA]n@u@pAYb@W\\\\UPYN]Na@PYHoBl@i@Ri@Vm@ZYRwAdAsAdAk@d@o@h@q@r@g@f@[`@Yf@[l@Uf@[j@_@x@e@v@Yb@OTQRg@n@e@j@OP[ZWX[V_@\\\\]Z]XYX_@b@m@p@i@p@s@~@i@t@kA`BcDnEi@j@m@l@g@d@YRwAbA{@n@aAx@q@h@YV]X{@r@eB|AYRWROLwAz@c@Rm@XE@[NSHm@T]LOJQLKJKNQZOZIXM^[~@MZcAjC[x@O^CJGN_@`AgA`D]`Ac@bA[n@CHWf@EFGJUb@MPGJUZIJEFGHCDWZMLKNKLQRIJQTIJIHMTEDOZOZQj@K\\\\KZQj@K`@[hAIXGRCJADW|@YbAWx@Qd@M\\\\GNGJILGJMNMNMJiAt@SJQHQHMDKBK@M@M?YAWBIAyAYOCQAQAS?M@M@[BqBZ}AV}AXODOFUJKDKDa@PQFQFIBG@O@O?e@AK?EAc@AkBKc@?O?Q@C?QBM@C@YDIBIDUF_@LuAd@]JQBKBe@Fg@DkAF[@YBQBS@OBQDe@JmAXYFyAXOBMBO@O@O@K?M?YCMAMAaAGeBM]CMC}E_@q@EmDYuCUi@Em@GMEMCMGaE}BmDmBiCsA]OQIUGOCMCEAICMAMAIAOAO?M?Y@UA[@Q?Y@E?U?a@?S@[?S?W?G?m@@G?ME}@@K?G?E@I@YFKDIBGBOFKJIFEDEBCCE?C?CBCBCBADAF?D?F@D?NAh@ANALARAXAb@?`@@`@@V@\\\\@^@TDXDb@FNDXHf@Jh@@FDPJj@Hb@DZ@J@D?D@J?F@T?V?hA?|F?h@?f@?n@?p@?\\\\?DAd@Af@Cf@O`EC^A^C^C^CZE^EZE\\\\Ib@If@Kf@Kb@EJEPIZMZKXKVKXMV[h@[h@OTMROPORQLOLQLSJQJUHc@ReAd@e@NMDMBOBG?E@s@Bq@BOG_BA]?E?iAA_@?U@OBa@FQFOHKDMLMLIHKLIJMTKVELIXEPEVCRANAXCz@EpBClE?HALAvAA\\\\Cf@APCRCTEXI^CLELELKRIJGDMFGBG@E?GAIAEAGCECECGGEEEGCEEGCIEIUq@Y{@Oa@M]GSSg@K]ISIMEMEGWWGGKGKEICGAEAGAE?E?E?I?I@KBMDKBEBq@b@SNGHOLMNILGHGJCDKVOZo@~AyBtF]z@yCpHEJ_@|@[v@KRIPIPILKJGHKFIDOHODC@OBQDSBkCX_@FMD]@[AM?]CQCSCi@ESAQAK?K@M@QDQDKDOHQJC@IFKJONGHIJKPy@tAi@t@i@r@kAzAUXKDONGHYZaAnAEFUXQPMLIFMPCAC@C@CBMBOBG@I@O@M@I?K?M?OCMASCWEc@EmAO{C_@aAMcAOu@Ii@GOCG?GAmBW_CWiAMICgBUKA[CQCcBSo@Ca@CIAmC[OAuASu@SYMOICCACCACAC?G@C@ABCBADg@AYEWGWIC?QIGAg@Uk@So@W]O_@M[Mi@So@Ue@Ss@WUKMG_@M_A_@yB}@[KmBu@w@YOIkAc@aBq@{@Wa@IQEeAQYEcAO_@IgAOk@ICAODE?[AIAOCa@OECCCCACACAC?KMOWUi@]u@IUOOQu@EKCICGGIEGEEEEECGEGAGAK?EAG?UBQDMDYHm@TUFGBK@G?IAG?ICCAEAGGGEIOGIGMe@aAEGCCEEEEIGGEECIAGCMAK?G?K@KBODyAf@gA\\\\[JcCt@GBm@Pa@Fc@DW@E?c@AM?KAI?OCs@OIAcF_AMCMCiAUkAU_@I}Ac@WI_A[q@WKCKCC?G?E?E?C?C@E@EBGBIFKFIDUP]TIFOJGDGDGBQBEBSFI?GAC?CAECECEEEICGCGAGAGEOAMCI?GKw@Io@AKMuAAG?G?s@?UAIAMAKCKc@yBOw@Ms@m@}CUoAMOa@yB]wBG]UsAKs@KgAQuBQyBGm@Eo@C]Ce@Cu@MiD@U@Y@O@WBEDK@E?G?GAGAECGCCEMCICMAKEK[mK?OAWCy@A}@?aC?S@MD}AH{ABWT{DHsA@Q@MDm@Do@Dy@@GDk@?INyB?IB[Dw@F}@@O@IPu@@GDABCBEBE@G@G?G?GAGCGCECCECCAE?E@EBCBU?O?C?K@G?I@I?SAYCk@GGAICKCMGYQWYWYa@o@e@{@c@}@[q@Um@UeAGk@AKSyAKg@EYEO[iAa@sASq@U{@GSCK?E?GAEAECECCCCFQJ_@^eAVq@HWBENYLY@ELYDIDKJDB@FDd@^DBDDBD@HBH?H@F?FCvC?F?HADADCF";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ClimaGuard")),
      body: Stack(
        children: [
          Column(
            children: [
            RouteDetailsCardWidget(
                startDate: widget.startDate,
                endDate: widget.endDate,
                origin: widget.origin,
                destination: widget.destination,
                waypoints: widget.waypoints
              ),
              Expanded(
                child: GoogleMapWidget(
                  interpolatedPoints: interpolatedPoints,
                  polyline: polyline,
                )
              ),
            ],
          ),
          RecommendationContainerWidget()
        ],
      ),
    );
  }
}
