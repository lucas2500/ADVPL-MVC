#INCLUDE "protheus.ch"
#INCLUDE "parmtype.ch"
#INCLUDE "FwMvcFef.ch"

User Function MVC001()

	//-- Construtor da classe
	Local oBrowse := FwMBrowse()::New()

	//-- Seta o Alias da tabela e o título da rotina
	oBrowse:SetAlias("ZZB")
	oBrowse:SetDescription("Albuns")

	//-- Controla legendas
	oBrowse:AddLegend("ZZB->ZZB_TIPO == '1'", "GREEN", "CD")
	oBrowse:AddLegend("ZZB->ZZB_TIPO == '2'", "BLUE", "DVD")

	//-- Ativa o browse criado
	oBrowse:Activate()

Return

Static function MenuDef()

	Local aRotina := {}
    Local aRotAux := FWMvcMenu()

    Add OPTION aRotina TITLE "Informação" ACTION "U_InfoMVC()" OPERATION 6 ACCESS 0

    For nI := 1 To Len(aRotAux)

        aAdd(aRotina, aRotAux[nI])

    Next nI

    /*
    MVC operations

    1 - Pesquisar
    2 - Visualizar
    3 - Incluir
    4 - Alterar
    5 - Excluir
    5 - (Chama função customizada)
    7 - Copiar
    */

    /*
	Add OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.MVC001" OPERATION 2 ACCESS 0
	Add OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.MVC001" OPERATION 3 ACCESS 0
	Add OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.MVC001" OPERATION 4 ACCESS 0
	Add OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.MVC001" OPERATION 5 ACCESS 0
    Add OPTION aRotina TITLE "Informação" ACTION "U_InfoMVC()" OPERATION 6 ACCESS 0
    */

Return aRotina

Static Function ModelDef()

	Local oModel := Nil
	Local oStZZB := FWFormStruct(1, "ZZB")

	//-- Instancia o model
	oModel := MPFormModel():New("ZMODELLM", , , ,)

    //-- Adiciona campos no model
    oModel:AddFields("FORMZZB", , oStZZB)

    //-- Seta chave primária do model
    oModel:SetPrimaryKey({"ZZB_FILIAL", "ZZB_COD"})

    oModel:SetDescription("Modelo de dados")

    oModel:GetModel("FORMZZB"):SetDescription("Formulário de cadastro")

Return oModel

Static Function ViewDef()

    // Local aStruZZB := ZZB->(DbStruct())
    Local oView    := Nil
    Local oModel   := FWLoadModel("MVC001")
    Local oStZZB   := FWFormStruct(2, "ZZB")

    oView := FWFormView():New()

    oView:SetModel(oModel)

    //-- Remove o campo da view
    //-- oStZZB:RemoveField("ZZB_USER")
    
    oView:AddFields("VIEW_ZZB", oStZZB, "FORMZZB")

    //-- Salva os elementos na tela em um container horizontal, também há a opção CreateVerticalBox
    oView:CreateHorizontalBox("TELA", 100)

    oView:EnableTitleView("VIEW_ZZB", "Dados View")

    oView:SetCloseOnOk({|| .T.})

    oView:SetOwnerView("VIEW_ZZB", "TELA")

Return oView

User Function InfoMVC()

    Local cMsg := "Olá Mundo!!"

    MsgInfo(cMsg)

Return 
