function customRender(ReactEle, Container){
    const domEle = document.createElement
    (ReactEle.type)
    domEle.innerHTML = ReactEle.children
    domEle.setAttributes('href',ReactEle.props.href)
    domEle.setAttributes('target' , ReactEle.props.target)

    Container.appendChild(domEle)
}
const RectEle = {
    type: 'a',
    props: {
        href: 'https://google.com',
        target:'blank',
    },
    Children:'Click to visit google'
}
const Container = document.querySelector('#root')

customRender(RectEle, Container)