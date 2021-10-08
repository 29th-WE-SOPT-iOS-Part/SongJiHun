//
//  ModuleFactory.swift
//  sopt_29th_Assignment
//
//  Created by 송지훈 on 2021/10/08.
//

import UIKit


/**
  - Description:
 
          ViewController 인스턴스를 넘기기 이전 뷰컨들에서 생성하는 것이 아닌,
          Moduel Factory 클래스로 구분시켜, 싱글턴 형태의 Factory 내에서 뷰컨을 찍어내서
          화면전환이 필요한 각각 뷰컨에 전달해주는 형태로 구성됩니다.
 
          이후 Coordinator 패턴으로 확장시켜 적용가능.
 
  - 사용법:
          1) ModuelFactoryProtocol에 넘겨야할 VC를 메서드 형태로 정의만 한다.
          2) ModuleFactory를 extension해서 구현해야 할 부분을 직접 작성한다.
              controllerFromStoryboard(익스텐션)를 활용해서 인스턴스를 생성한다
 
          3) 각각 필요한 VC내에서 MoudleFactory를 가지고 뷰컨을 가져오면 끝!
      
          
*/

protocol ModuleFactoryProtocol {


}


class ModuleFactory : ModuleFactoryProtocol{
  static func resolve() -> ModuleFactory {
    return ModuleFactory()
  }
}



// MARK: Account Scene
extension ModuleFactory {

}
