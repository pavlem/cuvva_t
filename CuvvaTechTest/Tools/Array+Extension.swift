//
//  Array+Extension.swift
//  CuvvaTechTest
//
//  Created by Pavle Mijatovic on 3.10.21..
//

import Foundation

extension Array {
    func unique(selector:(Element,Element)->Bool) -> Array<Element> {
        return reduce(Array<Element>()){
            if let last = $0.last {
                return selector(last,$1) ? $0 : $0 + [$1]
            } else {
                return [$1]
            }
        }
    }
}
