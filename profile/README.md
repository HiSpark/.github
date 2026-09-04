> **镜像说明：** 本 GitHub 组织用于镜像 [GitCode HiSpark 开源社区](https://gitcode.com/HiSpark) 的公开仓库；社区治理、问题反馈与代码贡献以 GitCode 为准。

## 社区仓库介绍

### 代码仓在线文档

| 模块 | 代码仓 | 链接 |
|----|----|----|
| 星闪 | [ws63](https://gitcode.com/HiSpark/fbb_ws63) | [WS63指导资料](https://docs.hisilicon.com/repos/fbb_ws63/zh-CN/master/) |
| 星闪 | [ws53](https://gitcode.com/HiSpark/fbb_ws53) | [WS53指导资料](https://gitcode.com/HiSpark/fbb_ws53/tree/master/docs/zh-CN) |
| 星闪 | [bs2x](https://gitcode.com/HiSpark/fbb_bs2x) | [BS2X指导资料](https://docs.hisilicon.com/repos/fbb_bs2x/zh-CN/master) |
| 视觉 | [Hi3516CV610](https://gitcode.com/HiSpark/Hi3516CV610) | [Hi3516CV610指导资料](https://gitcode.com/HiSpark/Hi3516CV610/tree/main/docs/soc) |
| 星闪 | [谛听模组](https://gitcode.com/HiSpark/hs-fbb) | [谛听模组指导资料](https://gitcode.com/HiSpark/hs-fbb/tree/master/docs/docs-zh_CN) |
| 开源项目联盟 | [开源项目联盟仓](https://gitcode.com/HiSpark/opensource-community) | [开源项目联盟指导](https://gitcode.com/HiSpark/opensource-community/blob/master/README.md) |

### 联接解决方案

#### 1.星闪代码仓_LiteOS系统( [ws63](https://gitcode.com/HiSpark/fbb_ws63)、[ws53](https://gitcode.com/HiSpark/fbb_ws53)、[bs2x](https://gitcode.com/HiSpark/fbb_bs2x)、[谛听模组](https://gitcode.com/HiSpark/hs-fbb))

ws63仓、ws53仓、bs2x仓、谛听模组仓的SDK包从统一开发平台FBB（Family Big Box，统一开发框架，统一API）构建而来，在该平台上开发的应用很容易被移植到其他星闪解决方案上，有效降低开发者门槛，缩短开发周期，支持开发者快速开发星闪产品，例如SLE/Wi-Fi共存、SLE灯控、SLE透传、SLE1对8透传等。

## 社区用户行为准则

HiSpark社区遵守开源社区[《贡献者公约》](https://contributor-covenant.org/)V1.4中规定的行为守则，请参考[V1.4版本](https://www.contributor-covenant.org/zh-cn/version/1/4/code-of-conduct.html)，如需举报侮辱、骚扰或其他不可接的行为，您可以在[开发者论坛](https://developer.hisilicon.com/forum/all)联系版主处理，详细内容参考[行为准则](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E8%A1%8C%E4%B8%BA%E5%87%86%E5%88%99.md)。

## 社区参与贡献

1.案例开发完成，需要提供配套文档，请先获取模板[Demo配套模板](https://gitcode.com/HiSpark/docs/blob/master/template/Demo%E9%85%8D%E5%A5%97%E6%A8%A1%E6%9D%BF.md)，根据模板完善内容。

2.案例、文档需要提供对应许可证及版权头，详情请参考：[许可证与版权规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E8%AE%B8%E5%8F%AF%E8%AF%81%E4%B8%8E%E7%89%88%E6%9D%83%E8%A7%84%E8%8C%83.md)

3.如果提供的案例涉及第三方开源软件，请参考[社区第三方开源软件引入指导](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E7%A4%BE%E5%8C%BA%E7%AC%AC%E4%B8%89%E6%96%B9%E5%BC%80%E6%BA%90%E8%BD%AF%E4%BB%B6%E5%BC%95%E5%85%A5%E6%8C%87%E5%AF%BC.md)补充相关内容，如果不涉及选择跳过，直接参考步骤4。

4.案例、文档已经准备完成，请参考[社区参与贡献指南贡献流程章节](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E7%A4%BE%E5%8C%BA%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE%E6%8C%87%E5%8D%97.md)提交PR。

5.PR提交完成，在扫描过程中遇到Codecheck等问题，请参考[社区参与贡献指南贡献代码要求章节](https://gitcode.com/HiSpark/docs/blob/master/contribute/C%E8%AF%AD%E8%A8%80%E7%BC%96%E7%A8%8B%E8%A7%84%E8%8C%83.md)进行修改。

6.如果扫描遇到开源合规告警（sca_scan），请参考[FossLicense开源合规告警澄清规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/FossLicense%E5%BC%80%E6%BA%90%E5%90%88%E8%A7%84%E5%91%8A%E8%AD%A6%E6%BE%84%E6%B8%85%E8%A7%84%E8%8C%83.md)进行修改。

7.如果扫描遇到工具问题导致的误报或者规范例外场景可以申请屏蔽，详情请参考[社区代码合入要求屏蔽指导章节](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E7%A4%BE%E5%8C%BA%E4%BB%A3%E7%A0%81%E5%90%88%E5%85%A5%E8%A6%81%E6%B1%82.md)。

8.如果扫描通过，仓库管理者会合入到主干

## 社区问题支持

- 在开发者论坛提问或者寻找其他帖子问题，详情请参考[支持渠道](https://developers.hisilicon.com/forum/all)。

## 社区整体流程规范

如果需要在HiSpark上架代码、开发板、文档等，整体流程及规范请参考[社区代码仓运作规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E7%A4%BE%E5%8C%BA%E4%BB%A3%E7%A0%81%E4%BB%93%E8%BF%90%E4%BD%9C%E8%A7%84%E8%8C%83.md)。

## 社区硬件上架规范

如果需要上架硬件开发板，需要提供硬件原理图、配套文档、购买链接、技术支持，详情请参考[社区开发板上架规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E7%A4%BE%E5%8C%BA%E5%BC%80%E5%8F%91%E6%9D%BF%E4%B8%8A%E6%9E%B6%E8%A7%84%E8%8C%83.md)。

## 社区文档上架规范。

如果需要上架资料文档，需要根据模板完善内容，请参考[开源社区文档写作规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/%E5%BC%80%E6%BA%90%E7%A4%BE%E5%8C%BA%E6%96%87%E6%A1%A3%E5%86%99%E4%BD%9C%E8%A7%84%E8%8C%83.md)。

## 社区代码上架规范

如果需要上架代码，根据不同语言选择不同的规范，参考如下：

- [C语言编程规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/C%E8%AF%AD%E8%A8%80%E7%BC%96%E7%A8%8B%E8%A7%84%E8%8C%83.md)
- [C++语言编程规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/C++%E8%AF%AD%E8%A8%80%E7%BC%96%E7%A8%8B%E8%A7%84%E8%8C%83.md)
- [Python语言编程规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/Python%E8%AF%AD%E8%A8%80%E7%BC%96%E7%A8%8B%E8%A7%84%E8%8C%83.md)

## 社区 API 上架规范

如果需要新开发接口，参考 HiSpark 社区 API 规范进行新增，参考如下：

- [API规范](https://gitcode.com/HiSpark/docs/blob/master/contribute/HiSpark_api_guidelines.md)

## 社区漏洞治理

主要包括漏洞处理策略、漏洞处理流程、漏洞公告，请参考[漏洞治理](https://gitcode.com/HiSpark/docs/blob/master/security/README.md)
